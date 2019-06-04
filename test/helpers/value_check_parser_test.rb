require 'test_helper'

class ValueCheckParserTest < ActiveSupport::TestCase

  setup do
    
  end

  test "class choice value check" do
    p= ValueCheckParser.for '1.2~2.3'
    assert p.class== RangeValueCheckParser
    p= ValueCheckParser.for '1.1.2'
    assert p.class== PointValueCheckParser
  end
end


