require 'test_helper'

class SqlTreeTest < ActiveSupport::TestCase

  test "SqlTree node classes" do
    assert SqlTree.all_node_classes.to_set == [:relation,:peer,:foreign,:where,:table,:column,:range,:string,:number,:date,:order,:position].to_set
  end

  test "zero SqlTree" do
    sqt =  SqlTree.from_lines ''    
    assert sqt.size == 0 
    assert sqt.depth == 0 
   assert sqt.tables == '' 
  end

  test "one table SqlTree" do
    sqt =  SqlTree.from_lines 'table tab'
    assert sqt.size == 1
    assert sqt.depth == 1
    assert sqt.tables == 'tab' 
  end


  test "create SqlTree from lines test" do
    sqt = SqlTree.from_lines  <<-SIMPLE_FROM_LINES
table employees
  column  name
  column  surname
  column  age
    range 10..20
SIMPLE_FROM_LINES
    assert sqt.depth == 3
    assert sqt.size == 5
    assert sqt.tables == 'employees'
  end

  test "SqlTree to sql" do
  end

end
