require "pry"
require_relative 'node'

class CompleteMe

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

  def count(current_node = @root, current_count = 0)
    @words = current_count
    if current_node.end_of_word
      @words += 1
    end
    current_node.links.each_key do |key|
      count(current_node.links[key], @words)
    end
    @words
  end

  def populate(dictionary)
    file = File.open(dictionary, "r")
    file.each do |line|
      insert(line)
    end
  end
end
