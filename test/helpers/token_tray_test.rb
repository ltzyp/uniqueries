require 'test_helper'

class TokenTrayTest < ActiveSupport::TestCase

  setup do
  end

  test "tray opened" do
    t = TokenTray.new
    t.open
    t.receive "open"
    assert t.content== ["open"] 
  end

  test "tray closed" do
    t = TokenTray.new
    t.close
    t.receive "closed"
    assert t.content== []   
  end
  
  test "tray sequence" do
    t = TokenTray.new
    t.open
    t.receive "1"
    t.close
    t.receive "2"
    t.receive "3"
    t.open
    t.receive "4"
    t.receive "5"
     assert t.content== ["1","4","5"]    
  end
  
end
