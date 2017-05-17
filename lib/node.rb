class Node
  attr_reader :letter, :links, :selected_words, :end_of_word
  def initialize(letter)
    @letter = letter
    @links = {}
    @end_of_word = false
    @selected_words = {}
  end

  def set_link(key, value)
    if key.class == String && key.length == 1 && value.class == Node
      @links[key] = value
    end
  end

  def set_end_of_word
    @end_of_word = true
  end

  def set_selected_word(key, value)
    if key.class == String && value.class == Fixnum
      @selected_words[key] = value
    end
  end
end
