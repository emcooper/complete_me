require './lib/node'
require './lib/file_io'

class CompleteMe 
  attr_reader :root

  def initialize
    @root = Node.new(nil)
  end

  def insert(word, current_node = @root)
    chompped_letters(word).each do |letter|
      set_node(letter, current_node) unless link_exists?(letter, current_node)
      current_node = next_node(letter, current_node)
    end
    current_node.set_end_of_word
  end

  def chompped_letters(word)
    word.chomp.chars
  end

  def set_node(letter, current_node)
    current_node.set_link(letter, Node.new(letter))
  end


  def count(current_node = @root)
    word_count = 0
    word_count = 1 if current_node.end_of_word
    current_node.links.each_value do |value|
      word_count += count(value)
    end
    word_count
  end

  def populate(input)
    input = list.open_file if input.class == File
    input.each_line { |line| insert(line) }
  end

  def suggest(substring)
    all_words = find_words(substring.chop, end_node(substring))
    unselected = unselected_words(all_words, substring)
    sorted_selected = sort_selected_words(substring)
    sorted_selected + unselected
  end

  def sort_selected_words(substring)
    previously_selected = end_node(substring).selected_words
    sorted_pairs = previously_selected.sort_by { |_k, v| v }.reverse
    sorted_pairs.map { |pair| pair[0] }
  end

  def unselected_words(all_words, substring)
    previously_selected = end_node(substring).selected_words
    all_words.reject { |word| previously_selected.keys.include? word }.sort
  end

  def end_node(string)
    counter = 0
    current_node = @root
    chompped_letters(string).each do |letter|
      if link_exists?(letter, current_node)
        current_node = next_node(letter, current_node)
        counter += 1
      end
    end
    current_node if counter == string.length
  end

  def find_words(substring, current_node, complete_words = [])
    word = substring + current_node.letter
    complete_words << word if current_node.end_of_word
    current_node.links.each_value do |value|
      find_words(word, value, complete_words)
    end
    complete_words
  end

  def select(substring, word)
    return nil if substring_not_included?(word, substring)
    if end_node(substring).selected_words[word].nil?
      end_node(substring).set_selected_word(word, 0)
    end
    end_node(substring).set_selected_word(word, end_node(substring).selected_words[word] + 1)
  end

  def substring_not_included?(word, substring)
    word[0..substring.length - 1] != substring
  end

  def link_exists?(letter, current_node)
    !current_node.links[letter].nil?
  end

  def next_node(letter, current_node)
    current_node.links[letter]
  end
end
