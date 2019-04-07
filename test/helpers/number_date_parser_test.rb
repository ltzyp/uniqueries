require 'test_helper'

class NumberDateParserTest < ActiveSupport::TestCase

  setup do
  end

  test"Basic Test" do
    d = NumberDateParser.new '2019.02.11.02.03.01'
    d.convert
    assert d.tokens == ['2019','02','11','02','03','01']
    assert d.value == DateTime.new(2019,2,11,2,3,1)
    assert d.to_SQLite == "datetime('2019-02-11-02-03-01')"
  end

end

