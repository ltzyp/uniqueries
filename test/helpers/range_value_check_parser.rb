require 'test_helper'

class RangeValueCheckParserTest < ActiveSupport::TestCase
  test "Registers value check" do
    
    r = RangeValueCheckParser.new '1~2'
    r.convert
    assert r.value == NumberRange(1..2)
  end
end

