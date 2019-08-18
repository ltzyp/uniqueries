require 'test_helper'

class SqlNodeTest < ActiveSupport::TestCase

  setup do
    @st0 = SqlTree.create
    @st = @st0.create_sql_node
  end

  test "node creation" do 
    nd = @st.sql_nodes.create( node_class: 'table',value: 'table_name')
    assert [nd.sql_tree_id ,nd.node_class,nd.value, nd.level] == [@st.id ,'table','table_name', 1]
    nd1 = nd.sql_nodes.create(node_class: 'column', value: 'column_name')
    assert [nd1.sql_tree_id,nd1.node_class,nd1.value,nd1.level] == [@st.id,'column','column_name',2 ]
    nd2 = nd1.sql_nodes.create(node_class: 'range', value: 'range_value')
    assert [nd2.sql_tree_id,nd2.node_class,nd2.value,nd2.level] == [@st.id,'range','range_value',3 ]

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
  end

end