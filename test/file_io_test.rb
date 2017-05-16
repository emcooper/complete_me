require_relative 'test_helper'
require_relative '../lib/file_io'

class FileIoTest < Minitest::Test
  def test_returns_open_file
    new_file_io = FileIo.new
    
    file_path = "/usr/share/dict/words"
    
    refute new_file_io.open(file_path).closed?
  end 
end 