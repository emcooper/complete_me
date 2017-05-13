class Node
  attr_reader :letter
  attr_accessor :links, :end_of_word, :times_selected

  def initialize(letter)
    @letter = letter
    @links = {}
    @end_of_word = false
    @times_selected = 0
  end
end
