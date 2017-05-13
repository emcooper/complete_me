require_relative 'node'

class Trie

  attr_accessor :root
  def initialize
    @root = Node.new(nil)
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

end
