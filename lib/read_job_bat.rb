require_relative "read_job_bat/version"

module ReadJobBat
  class Error < StandardError; end
  class ReadJobBat

    def get_fullpath_bat(drive, dir, bat)
      unless bat.match("\:")
        if drive=="" and dir==""
          dirname="\.\\"
        else
          dirname=drive + dir + "\\"
        end
      else
        dirname=""
      end
      dirname + bat
    end

    def readbat(s)
      ar=[]
      drive=dir=""
      s.split("\n").each do |line| 
        drive = line if line =~/[A-Za-z]\:/ and line.strip.length==2
        dir = line.split("\s")[1] if line.downcase =~ /^cd /
        if line.downcase =~ /^call/
          ar.push get_fullpath_bat(drive, dir, line.split("\s")[1])
        end
      end
      ar
    end

    def mainline(batfile)
      f = File.open(batfile)
      input = f.read
      f.close
      output(batfile,readbat(input))
    end

    def output(batfile, items)
      items.each do |bat|
        puts batfile + "\t" + bat
      end
    end

  end 
end

if $0==__FILE__
  if ARGV.length < 1
    puts "Specify input bat"
    exit(1)
  end 
  o=ReadJobBat::ReadJobBat.new
  o.mainline(ARGV[0])
end