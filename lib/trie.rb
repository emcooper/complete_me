require "pry"
require_relative 'node'

#need to change class name to CompleteMe
class Trie

  attr_accessor :root
  
  def initialize
    @root = Node.new(nil)
    @words = 0
  end

  def insert(word, current_node = @root)
    manipulate_word(word).each do |letter|
      if current_node.links[letter].nil?
        current_node.links[letter] = Node.new(letter)
        current_node = current_node.links[letter]
      end
    end
    current_node.end_of_word = true
  end

  def manipulate_word(word)
    downcased = word.downcase
    downcased.chars
  end
  
  def count(current_node = @root)
    if current_node.end_of_word 
      @words += 1
    end 
    current_node.links.each do |key, value|
      if key != nil?
        count(current_node.links[key])
      end 
    end 
    @words
  end 
  
end
