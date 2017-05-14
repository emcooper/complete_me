require "pry"
require_relative 'node'

class CompleteMe

  attr_accessor :root

  def initialize
    @root = Node.new(nil)
  end

  def insert(word, current_node = @root)
    word.chars.each do |letter|
      if current_node.links[letter].nil?
        current_node.links[letter] = Node.new(letter)
      end
      current_node = current_node.links[letter]
    end
    current_node.end_of_word = true
  end

  def count(current_node = @root)
    word_count = 0
    if current_node.end_of_word
      word_count += 1
    end
    current_node.links.each_value do |value|
      word_count += count(value)
    end
    word_count
  end

  def populate(dictionary)
    file = File.open(dictionary, "r")
    file.each do |line|
      insert(line)
    end
  end
  
  def suggest(substring)
    substring_end_node = end_node(substring)
    find_words(substring.chop, substring_end_node)
    #todo: sort words by score
  end 
  
  def end_node(string)
    counter = 0
    current_node = @root
    string.each_char do |char|
      if current_node.links[char] != nil
        current_node = current_node.links[char] 
        counter += 1
      end 
    end
    if counter == string.length
      current_node 
    end 
  end 
  
  def find_words(word, current_node, complete_words = [])
    word = word + current_node.letter
    if current_node.end_of_word 
      complete_words << word
    end 
    current_node.links.each_value do |value|
      find_words(word, value, complete_words)
    end 
    complete_words
  end 
end
