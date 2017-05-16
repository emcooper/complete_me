require "pry"
require_relative '../lib/node'

class CompleteMe

  attr_reader :root

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
  #todo: add feature to insert?

  def populate(dictionary)
    file = File.open(dictionary, "r")
    file.each do |line|
      insert(line)
    end
  end

  def suggest(substring)
    all_words = find_words(substring.chop, end_node(substring))
    unselected_words = all_words.reject {|word| end_node(substring).selected_words.keys.include? word}.sort
    selected_nested_collection = end_node(substring).selected_words.sort_by {|k, v| v}.reverse
    selected_nested_collection.map! {|pair| pair[0]}
    final_suggestion = selected_nested_collection + unselected_words
  end

  def end_node(string)
    counter = 0
    current_node = @root
    string.each_char do |char|
      if current_node.links[char]
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

  def select(substring, word)
    if word[0..substring.length-1] == substring
      if end_node(substring).selected_words[word].nil?
        end_node(substring).selected_words[word] = 0
      end
      end_node(substring).selected_words[word] += 1
    end
  end

end
