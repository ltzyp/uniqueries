require 'test_helper'

class QtextTest < ActiveSupport::TestCase
   test "input string" do
      (q= Qline.new text: "a:b#c").parse

       assert q.qsource=== 'a:b'
       assert q.qtapestry=== 'c'
   end

end
