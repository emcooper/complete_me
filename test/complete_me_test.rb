require_relative 'test_helper'
require_relative '../lib/complete_me'


class CompleteMeTest < Minitest::Test
  def test_root_is_node_with_nil_letter
    tree = CompleteMe.new

    assert_nil tree.root.letter
  end

  def test_insert_1_letter_word
    trie = CompleteMe.new

    trie.insert('p')

    assert_equal ['p'], trie.root.links.keys
  end

  def test_insert_2_letter_word
    trie = CompleteMe.new

    trie.insert('pi')

    assert_equal ['p'], trie.root.links.keys
    assert_equal ['i'], trie.root.links['p'].links.keys
  end

  def test_insert_5_letter_word
    trie = CompleteMe.new

    trie.insert('pizza')

    assert_equal ['p'], trie.root.links.keys
    assert_equal ['i'], trie.root.links['p'].links.keys
    assert_equal ['z'], trie.root.links['p'].links['i'].links.keys
    assert_equal ['z'], trie.root.links['p'].links['i'].links['z'].links.keys
    assert_equal ['a'], trie.root.links['p'].links['i'].links['z'].links['z'].links.keys
  end

  def test_insert_marks_end_of_1_word
    trie = CompleteMe.new

    trie.insert('pizza')

    assert trie.root.links['p'].links['i'].links['z'].links['z'].links['a'].end_of_word
    refute trie.root.links['p'].end_of_word
    refute trie.root.links['p'].links['i'].end_of_word
    refute trie.root.links['p'].links['i'].links['z'].end_of_word
    refute trie.root.links['p'].links['i'].links['z'].links['z'].end_of_word
  end

  def test_insert_marks_end_of_10_words
    #todo
    trie = CompleteMe.new

    insert_10_words(trie)

    assert trie.root.links['p'].links['i'].links['z'].links['z'].links['a'].end_of_word
    assert trie.root.links['p'].links['i'].links['z'].links['z'].links['e'].links['r'].links['i'].links['a'].end_of_word
    assert trie.root.links['p'].links['e'].links['p'].links['p'].links['e'].links['r'].links['o'].links['n'].links['i'].end_of_word
    assert trie.root.links['p'].links['e'].links['p'].links['p'].links['e'].links['r'].end_of_word
  end

  def test_counts_1_word
    trie = CompleteMe.new

    trie.insert('pizza')

    assert_equal 1, trie.count
  end

  def test_counts_10_words
    trie = CompleteMe.new

    insert_10_words(trie)

    assert_equal 10, trie.count
  end

  def test_counts_correctly_if_called_twice
    trie = CompleteMe.new

    insert_10_words(trie)

    assert_equal 10, trie.count
    assert_equal 10, trie.count
  end

  def test_populate_inserts_words
    trie = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")
    trie.populate(dictionary)

    assert_equal 235886, trie.count
  end

  def test_suggests_correct_words
    trie = CompleteMe.new

    insert_30_words(trie)

    assert_equal ["pepper", "pepperoni"], trie.suggest("pe")
    assert_equal ["abhorrence", "abhorrer", "abhorrible"], trie.suggest("abh")
  end
  
  def test_suggest_returns_in_sorted_order
    trie = CompleteMe.new

    insert_30_words(trie)

    trie.select('p', 'pizza')
    trie.select('p', 'pizza')
    trie.select('p', 'pizza')
    trie.select('p', 'pepperoni')

    assert_equal ["pizza", "pepperoni", "pepper", "pizzeria"], trie.suggest("p")
    assert_equal ["pepper","pepperoni"], trie.suggest("pe")
  end

  def test_end_node_returns_last_node_of_string
    trie = CompleteMe.new

    insert_10_words(trie)

    assert_equal "r", trie.end_node("pepper").letter
    assert_equal "n", trie.end_node("hawaiian").letter
  end

  def test_end_node_returns_nil_for_nonexistent_string
    trie = CompleteMe.new

    insert_10_words(trie)

    assert_nil trie.end_node("pizzaroni")
  end
  
  def test_find_words_returns_all_complete_words_of_substring
    trie = CompleteMe.new

    insert_30_words(trie)
    
    assert_equal ["pizza", "pizzeria", "pepper", "pepperoni"], trie.find_words("p".chop, trie.end_node("p"))
    assert_equal ["abacay","abaculus"], trie.find_words("abac".chop, trie.end_node("abac")) 
  end 

  def test_selected_word_increments_by_1
    trie = CompleteMe.new

    insert_10_words(trie)

    trie.select('piz', 'pizza')

    assert_equal 1, trie.end_node('piz').selected_words['pizza']
  end

  def test_selected_word_incremented_by_3
    trie = CompleteMe.new

    insert_10_words(trie)

    trie.select('piz', 'pizza')
    trie.select('piz', 'pizza')
    trie.select('piz', 'pizza')

    assert_equal 3, trie.end_node('piz').selected_words['pizza']
  end

  def test_selected_words_with_same_substring_increment_by_3
    trie = CompleteMe.new

    insert_10_words(trie)

    trie.select('piz', 'pizza')
    trie.select('piz', 'pizza')
    trie.select('piz', 'pizza')

    trie.select('piz', 'pizzeria')
    trie.select('piz', 'pizzeria')
    trie.select('piz', 'pizzeria')

    assert_equal 3, trie.end_node('piz').selected_words['pizza']
    assert_equal 3, trie.end_node('piz').selected_words['pizzeria']
  end

  def test_can_not_select_words_that_do_not_include_substring
    trie = CompleteMe.new

    insert_10_words(trie)

    trie.select('piz', 'pizza')
    trie.select('piz', 'pizza')
    trie.select('piz', 'pizza')

    trie.select('piz', 'marinara')
    trie.select('piz', 'marinara')
    trie.select('piz', 'marinara')

    assert_equal 3, trie.end_node('piz').selected_words['pizza']
    assert_nil trie.end_node('piz').selected_words['marinara']
  end

  def insert_10_words(trie)
    trie.insert('pizza')
    trie.insert('pizzeria')
    trie.insert('pepperoni')
    trie.insert('pepper')
    trie.insert('vegetarian')
    trie.insert('italian')
    trie.insert('neopolitan')
    trie.insert('marinara')
    trie.insert('hawaiian')
    trie.insert('sausage')
  end

  def insert_30_words(trie)
    trie.insert('pizza')
    trie.insert('pizzeria')
    trie.insert('pepperoni')
    trie.insert('pepper')
    trie.insert('vegetarian')
    trie.insert('italian')
    trie.insert('neopolitan')
    trie.insert('marinara')
    trie.insert('hawaiian')
    trie.insert('sausage')
    trie.insert('abacay')
    trie.insert('abaculus')
    trie.insert('abaissed')
    trie.insert('abalone')
    trie.insert('abaser')
    trie.insert('abhorrence')
    trie.insert('abhorrer')
    trie.insert('abhorrible')
    trie.insert('abidal')
    trie.insert('abidi')
    trie.insert('abietic')
    trie.insert('abietineous')
    trie.insert('abiosis')
    trie.insert('abir')
    trie.insert('abiston')
    trie.insert('Abkhas')
    trie.insert('abkar')
    trie.insert('Abner')
    trie.insert('abody')
    trie.insert('abolition')
  end
end
