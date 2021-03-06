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

    def get_pushd(drive, dir, drive_dir, pushpopd)
      pushpopd.push drive + dir
      drive = drive_dir.split("\\")[0]
      dir   = drive_dir.split("\:")[1]
      [drive, dir]
    end
    
    def get_popd(pushpopd)
      drive_dir = pushpopd.pop
      drive = drive_dir.split("\\")[0]
      dir   = drive_dir.split("\:")[1]
      [drive, dir]
    end

    def read_buffer(s)
      ar=[]
      pushpopd = []
      drive=dir=""
      s.split("\n").each do |line| 
        drive = line if line =~/[A-Za-z]\:/ and line.strip.length==2
        dir = line.split("\s")[1] if line.downcase =~ /^cd /
        drive, dir = get_pushd(drive, dir, line.split("\s")[1], pushpopd) if line.downcase =~/^pushd /
        drive, dir = get_popd(pushpopd)   if line.downcase =~/^popd/
        if (line.downcase =~ /^call/) or (line.downcase =~ /^ruby/)
          ar.push get_fullpath_bat(drive, dir, line.split("\s")[1])
        end
      end
      ar.uniq
    end

    def read_bat(batfile)
      begin
        f = File.open(batfile)
        input = f.read
        f.close
      rescue
        STDERR.puts "Can't open batfile: #{batfile}"
        input = ""
      end
      output(batfile,read_buffer(input))
    end

    def output(batfile, items)
      items.each do |bat|
        read_bat(bat) if bat =~ /.*\.bat$/
        puts batfile + "\t" + bat
      end
    end

  end 
end

## Entry point
if ARGV.length < 1
  puts "Specify input bat"
  exit(1)
end 
o=ReadJobBat::ReadJobBat.new
o.read_bat(ARGV[0])
