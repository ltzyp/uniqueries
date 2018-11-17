require 'test_helper'

class SyntaxtreeTest < ActiveSupport::TestCase
   test "input string" do
      (st= Trunk.new text: "a:b#c").parse

       assert st.source=== 'a:b'
       assert st.tape=== 'c'
   end

end
