class Node
  attr_reader :letter
  attr_accessor :links, :end_of_word, :times_selected, :selected_words

  def initialize(letter)
    @letter = letter
    @links = {}
    @end_of_word = false
    @selected_words = {}
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
