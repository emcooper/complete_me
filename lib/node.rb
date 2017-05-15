class Node
  attr_reader :letter
  attr_accessor :links, :end_of_word, :times_selected

  def initialize(letter)
    @letter = letter
    @links = {}
    @end_of_word = false
    @times_selected = 0
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
