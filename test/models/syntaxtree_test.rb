require 'test_helper'

class SyntaxtreeTest < ActiveSupport::TestCase
   test "short input string" do
      (st= Trunk.new text: "a:b#c").parse

       assert st.source=== 'a:b'
       assert st.tape=== 'c'
   end

  test "parse tape to ribbons" do
    tokens= [ 'c[1-2]','d[..4]','e[5]','g']
    input_string= tokens.join(',') 

    tp = Tape.new text: input_string, trunk: Trunk.new
    tp.parse
    tp.ribbons.zip(tokens){|s,t|  assert s=== t }

  end

  test "ribbon " do

    rb = Ribbon.new text: "s[1:3]", tape: Tape.new
    rb.parse
    assert rb.columnname=== "s"
    assert rb.limits[0]=== "1"
    assert rb.limits[1]=== "3"

  end

=begin
   test "input string" do
      tokens= ['a:b', 'c[1-2]','d[..4]','e[5]','g']
      input_string= tokens[0]+'#'+tokens[1..-1].join(',') 
      (st= Trunk.new text: input_string).create_children
 p "ribbons size: "+  st.tape.ribbons.size.to_s
       assert st.source=== 'a:b'
      st.tape.ribbons.zip tokens[1..-1] {|s,t| p s.text; assert s=== t }
#       assert st.tape.ribbons=== t okens[1..-1]
   end
=end
Minitest.after_run do
  p "after run"
end


end
