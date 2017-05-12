gem 'minitest', '~> 5.0'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/node'

class NodeTest < Minitest::Test
  def test_first_letter_and_default_values
    new_letter = Node.new('a')
    
    assert_equal 'a', new_letter.letter
    assert_equal ({}), new_letter.links
    refute new_letter.end_of_word
    assert_equal 0, new_letter.times_selected 
  end 
  
  def test_node_can_have_different_letter
    new_letter = Node.new('j')
    
    assert_equal 'j', new_letter.letter
  end 
  
  def test_node_can_have_link
    letter1 = Node.new('j')
    letter2 = Node.new('a')
    letter1.links['a'] = letter2
    
    assert_equal letter2, letter1.links['a']
    assert_equal 'a', letter1.links['a'].letter
  end 
  
  def test_end_of_word_can_be_true
    new_letter = Node.new('a')
    new_letter.end_of_word = true 

    assert new_letter.end_of_word
  end 
  
  def test_times_selected_can_increment
    new_letter = Node.new('a')
    new_letter.times_selected += 1
    
    assert_equal 1, new_letter.times_selected
  end 
end 