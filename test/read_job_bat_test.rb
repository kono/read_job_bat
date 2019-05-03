require "test_helper"

class ReadJobBatTest < Test::Unit::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::ReadJobBat::VERSION
  end

  def test_that_it_can_read_bat_strings
    target = ReadJobBat::ReadJobBat.new
    input =<<~EOS
    E:
    cd \\TEST\\bat
    call foobar.bat
    EOS
    assert target.readbat(input) == ['E:\TEST\bat\foobar.bat']
    input =<<~EOS
    E:
    cd \\TEST2\\bat
    call bazqux.bat
    EOS
    assert target.readbat(input) == ['E:\TEST2\bat\bazqux.bat']
    input =<<~EOS
    call E:\\TEST3\\bat\\quuxcorge.bat
    EOS
    p target.readbat(input)
    assert target.readbat(input) == ['E:\TEST3\bat\quuxcorge.bat']
  end

  def test_that_it_can_read_bat_files
    target = ReadJobBat::ReadJobBat.new
    f = File.open('test/simple_testbat.txt')
    s=f.read
    f.close
    assert target.readbat(s) == ['E:\TEST\bat\foobar.bat']
    
  end
end
