require './test/test_helper'
require './lib/node'

class NodeTest < Minitest::Test
  def test_first_letter_and_default_values
    new_letter = Node.new('a')

    assert_equal 'a', new_letter.letter
    assert_equal ({}), new_letter.links
    refute new_letter.end_of_word
    assert_equal ({}), new_letter.selected_words
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

  def test_selected_words_can_have_keys_and_values
    new_letter = Node.new('a')
    new_letter.selected_words['apple'] = 3
    new_letter.selected_words['animal'] = 6

    assert_equal 3, new_letter.selected_words['apple']
    assert_equal 6, new_letter.selected_words['animal']
  end
end
