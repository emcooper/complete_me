require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/trie'
require_relative '../lib/node'

class TrieTest < Minitest::Test
  def test_root_is_node_with_nil_letter
    tree = Trie.new

    assert_nil tree.root.letter
  end

  def test_insert_1_letter_word
    trie = Trie.new

    trie.insert('p')

    assert_equal ['p'], trie.root.links.keys
  end

  def test_insert_2_letter_word
    trie = Trie.new

    trie.insert('pi')

    assert_equal ['p'], trie.root.links.keys
    assert_equal ['i'], trie.root.links['p'].links.keys
  end

  def test_insert_5_letter_word
    trie = Trie.new

    trie.insert('pizza')

    assert_equal ['p'], trie.root.links.keys
    assert_equal ['i'], trie.root.links['p'].links.keys
    assert_equal ['z'], trie.root.links['p'].links['i'].links.keys
    assert_equal ['z'], trie.root.links['p'].links['i'].links['z'].links.keys
    assert_equal ['a'], trie.root.links['p'].links['i'].links['z'].links['z'].links.keys
  end

  def test_insert_marks_end_of_word
    trie = Trie.new

    trie.insert('pizza')

    assert trie.root.links['p'].links['i'].links['z'].links['z'].links['a'].end_of_word
    refute trie.root.links['p'].end_of_word
    refute trie.root.links['p'].links['i'].end_of_word
    refute trie.root.links['p'].links['i'].links['z'].end_of_word
    refute trie.root.links['p'].links['i'].links['z'].links['z'].end_of_word
  end
end
