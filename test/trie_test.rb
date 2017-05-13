require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/trie'
require_relative '../lib/node'

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

  def test_insert_marks_end_of_word
    trie = CompleteMe.new

    trie.insert('pizza')

    assert trie.root.links['p'].links['i'].links['z'].links['z'].links['a'].end_of_word
    refute trie.root.links['p'].end_of_word
    refute trie.root.links['p'].links['i'].end_of_word
    refute trie.root.links['p'].links['i'].links['z'].end_of_word
    refute trie.root.links['p'].links['i'].links['z'].links['z'].end_of_word
  end
  
  #later maybe test that insert functions correctly when substring of word already exists?
  
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
  
  def insert_10_words(trie)
    trie.insert('pizza')
    trie.insert('pizzeria')
    trie.insert('pepperoni')
    trie.insert('mozzarella')
    trie.insert('vegertarian')
    trie.insert('italian')
    trie.insert('neopolitan')
    trie.insert('marinara')
    trie.insert('hawaiian')
    trie.insert('sausage')
  end 
end
