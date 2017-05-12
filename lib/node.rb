class Node
  attr_reader :letter, :links
  attr_accessor :end_of_word, :times_selected
  def initialize(letter)
    @letter = letter 
    @links = {}
    @end_of_word = false
    @times_selected = 0
  end 
end 