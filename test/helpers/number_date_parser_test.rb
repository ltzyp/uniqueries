require 'test_helper'

class NumberDateParserTest < ActiveSupport::TestCase

  setup do
  end

  test "Formatters" do
     s= (NumberDateParser.formatters.map{|e| e.mark_char}).join
    assert s  == 'YmdHMS'

  end 
 
 test"Basic Test" do
    d = NumberDateParser.new '2018.02.11.02.03.01'
    d.convert
    assert d.tokens == ['2018','02','11','02','03','01']
    assert d.value == DateTime.new(2018,2,11,2,3,1)
    assert d.to_SQLite == "datetime('2018-02-11-02-03-01')"
  end


  test"Empty tokens test" do
    d = NumberDateParser.new '.02.11.02.03.01'
    d.convert
    assert d.value == DateTime.new(2019,2,11,2,3,1)

    d = NumberDateParser.new '2017.02.11.02..'
    d.convert
    assert d.value == DateTime.new(2017,2,11,2,0,0)

  end

end

