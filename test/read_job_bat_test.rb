require "test_helper"

class ReadJobBatTest < Test::Unit::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::ReadJobBat::VERSION
  end

  def setup
      @target = ReadJobBat::ReadJobBat.new
  end

  def test_that_it_can_read_bat_strings1
    input =<<~EOS
    E:
    cd \\TEST\\bat
    call foobar.bat
    EOS
    assert @target.read_buffer(input) == ['E:\TEST\bat\foobar.bat']
  end

  def test_that_it_can_read_bat_strings2
    input =<<~EOS
    E:
    cd \\TEST2\\bat
    call bazqux.bat
    EOS
    assert @target.read_buffer(input) == ['E:\TEST2\bat\bazqux.bat']
  end

  def test_that_it_can_read_bat_strings3
    input =<<~EOS
    call E:\\TEST3\\bat\\quuxcorge.bat
    EOS
    assert @target.read_buffer(input) == ['E:\TEST3\bat\quuxcorge.bat']
  end

  def test_that_it_can_read_bat_strings4
    input =<<~EOS
    pushd E:\\TEST4\\bat
    call graultgarply.bat
    EOS
    assert @target.read_buffer(input) == ['E:\TEST4\bat\graultgarply.bat']
  end

  def test_that_it_can_read_bat_strings5
    input =<<~EOS
    F:
    cd \\TEST5
    call foo.bat
    pushd E:\\TEST6\\bat
    call bar.bat
    popd
    call baz.bat
    EOS
    assert @target.read_buffer(input) == ['F:\TEST5\foo.bat','E:\TEST6\bat\bar.bat','F:\TEST5\baz.bat']
  end

  def test_that_it_can_read_bat_files
    f = File.open('test/simple_testbat.txt')
    s=f.read
    f.close
    assert @target.read_buffer(s) == ['E:\TEST\bat\foobar.bat']
    
  end
end
