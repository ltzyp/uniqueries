require 'test_helper'

class ContextTreeTest < ActiveSupport::TestCase

  test "ContextTree node classes" do
    assert ContextTree.all_node_classes.to_set == [:relation,:peer,:foreign,:where,:table,:column,:range,:string,:number,:date,:order,:position].to_set
  end

  test "zero ContextTree" do
    sqt =  ContextTree.from_lines ''    
    assert sqt.size == 1
    assert sqt.depth == 0 
   assert sqt.tables == '' 
  end

  test "one table ContextTree" do
    sqt =  ContextTree.from_lines 'table tab'
    assert sqt.size == 2
    assert sqt.depth == 1
    assert sqt.tables == 'tab' 
    assert sqt.context_node.context_tree.id == sqt.id
  end

  test 'clean context' do
    wpt= context_trees(:one)
    wpt.clean_context
    assert_empty wpt.context_node.context
  end


  test "create ContextTree from lines test" do
    sqt = ContextTree.from_lines  <<-SIMPLE_FROM_LINES
table employees
  column  name
  column  surname
  column  age
    range 10..20
SIMPLE_FROM_LINES
    assert sqt.depth == 3
    assert sqt.size == 6
    assert sqt.tables == 'employees'
  end

  test "ContextTree to sql" do
  end

end
