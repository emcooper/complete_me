
 require_relative './lib/complete_me.rb'
 
 trie = CompleteMe.new
 dictionary = File.read("/usr/share/dict/words")
 trie.populate(dictionary)
 
 Shoes.app :title => "CompleteMe", :width => 1000, :resizable => false do 
   background './images/shoes_background.jpg'
   flow :margin => [380, 100] do
     @edit_line = edit_line
     button('Complete Me') do 
       @slot.clear if @slot
       @suggestions = trie.suggest(@edit_line.text)
        @slot = flow :margin => [380, 0] do list_box items: @suggestions,
          choose: @suggestions.first do |list|
            trie.select(@edit_line.text, list.text)
        end
      end 
    end
  end 
end
 