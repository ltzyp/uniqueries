require 'test_helper'

class SyntaxtreeTest < ActiveSupport::TestCase
   test "short input string" do
      (st= Trunk.new text: "a:b#c").parse

       assert st.source=== 'a:b'
       assert st.tape=== 'c'
   end

   test "input string" do
      tokens= ['a:b', 'c[1-2]','d[..4]','e[5]','g']
      input_string= tokens[0]+'#'+tokens[1..-1].join(',') 
      (st= Trunk.new text: input_string).create_children
 p "ribbons size: "+  st.tape.ribbons.size.to_s
       assert st.source=== 'a:b'
      st.tape.ribbons.zip tokens[1..-1] {|s,t| p s.text; assert s=== t }
#       assert st.tape.ribbons=== t okens[1..-1]
   end


end
