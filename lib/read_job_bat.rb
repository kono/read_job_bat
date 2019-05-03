require "read_job_bat/version"

module ReadJobBat
  class Error < StandardError; end
  class ReadJobBat
    def initialize
    end

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
        drive = line if line =~/[A-Za-z]\:/ and line.length==2
        dir = line.split("\s")[1] if line.downcase =~ /^cd /
        if line.downcase =~ /^call/
          ar.push get_fullpath_bat(drive, dir, line.split("\s")[1])
        end
      end
      ar
    end

  end 
end
