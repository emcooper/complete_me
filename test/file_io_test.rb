require './test/test_helper'
require './lib/file_io'

class FileIoTest < Minitest::Test
  def test_returns_open_file
    new_file_io = FileIo.new

    file_path = "/usr/share/dict/words"

    new_file_io.open_file(file_path)

    refute new_file_io.open_file(file_path).closed?
  end
end
