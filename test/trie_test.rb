gem 'minitest', '~> 5.0'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/trie'

class TrieTest < Minitest::Test
  def test_root_is_node_with_nil_letter
    tree = Trie.new
    
    assert_nil tree.root.letter
  end 
end 