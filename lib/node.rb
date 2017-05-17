class Node
  attr_reader :letter, :links
  attr_accessor :end_of_word, :selected_words

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

  # def set_times_selected(input)
  #   if input.class = String
  #     @times_selected = input.to_i
  #end
end


# class Trie
#
#   def set_end
#     node.end_of_word = "true"
#   end
#
# end
