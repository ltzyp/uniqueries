require 'test_helper'

class SqlNodeTest < ActiveSupport::TestCase

  setup do
    @st = SqlTree.create
  end

  test "node creation" do 
    nd = @st.sql_nodes.create( node_class: 'table',value: 'table_name')
    assert [nd.sql_tree_id ,nd.node_class,nd.value] == [@st.id ,'table','table_name']
#    nd.save\
    nd1 = nd.sql_nodes.create(node_class: 'column', value: 'column_name')
    assert [nd1.sql_tree_id,nd1.node_class,nd1.value] == [@st.id,'column','column_name']

  end
 
  test "node iterator" do

    nd = @st.sql_nodes.create
    nd1 = nd.sql_nodes.create( node_class: 'table',value: 't1')
    nd2 = nd.sql_nodes.create( node_class: 'table',value: 't2')
    nd11 = nd1.sql_nodes.create( node_class: 'column',value: 'c11')
    nd12 = nd1.sql_nodes.create( node_class: 'column',value: 'c12')
    nd21 = nd2.sql_nodes.create( node_class: 'column',value: 'c21')
    nd22 = nd2.sql_nodes.create( node_class: 'column',value: 'c22')
    nd221 = nd22.sql_nodes.create( node_class: 'range', value: 'r221') 
    nd23 = nd2.sql_nodes.create( node_class: 'column',value: 'c23')
    
    t =''
    nd.each { |n | p (t + ''+ n.value); t = t + n.value }
    assert t == 't1c11c12t2c21c22r221c23' 
  end

end
