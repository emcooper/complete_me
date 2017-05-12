require_relative 'node'

class Trie 
  
  attr_reader :root
  def initialize
    @root = Node.new(nil)
  end 
  
end 