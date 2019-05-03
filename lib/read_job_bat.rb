require "read_job_bat/version"

module ReadJobBat
  class Error < StandardError; end
  class ReadJobBat
    def initialize
    end
    def readbat(s)
      ar=[]
      drive=dir=""
      s.split("\n").each do |line| 
        drive = line if line =~/[A-Za-z]\:/
        dir = line.split("\s")[1] if line.downcase =~ /^cd /
        p dir
        if line.downcase =~ /^call/
          if drive=="" and dir==""
            dirname="\.\\"
          else
            dirname=drive + dir + "\\"
          end
          ar.push dirname + line.split("\s")[1]
        end
      end
      p ar
      ar
    end
  end 
end
