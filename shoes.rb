
 require_relative './lib/complete_me.rb'
 
 trie = CompleteMe.new
 dictionary = File.read("/usr/share/dict/words")
 trie.populate(dictionary)
 
 Shoes.app :title => "CompleteMe" do 
   background 'http://m.c.lnkd.licdn.com/mpr/mpr/p/4/005/054/08f/3a55e47.jpg'
   flow do
     @edit_line = edit_line
     button 'Submit' do 
       @slot.clear if @slot
       @suggestions = trie.suggest(@edit_line.text)
        @slot = flow do list_box items: @suggestions,
          choose: @suggestions.first do |list|
            trie.select(@edit_line.text, list.text)
        end
      end 
    end
  end 
end
 