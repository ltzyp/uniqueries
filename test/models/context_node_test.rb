require 'test_helper'

class ContextNodeTest < ActiveSupport::TestCase

  setup do
    @st0 = ContextTree.create
    @st = @st0.create_context_node
    @st.context= {:st=>1}
    @st.save
  end

  test "first node creation" do
    assert @st.context_tree==@st0
  end

  test "node creation" do 
    nd = @st.context_nodes.create( node_class: 'table',value: 'table_name')
    assert [nd.context_tree_id ,nd.node_class,nd.value, nd.level] == [@st0.id ,'table','table_name', 1]
    assert nd.context=={:st=>1}
    nd.add_context( {:nd=>2} )
    nd.save
    assert nd.context=={:st=>1 ,:nd=>2}
    nd1 = nd.context_nodes.create(node_class: 'column', value: 'column_name')
    assert nd1.context=={:st=>1 ,:nd=>2}

    assert [nd1.context_tree_id,nd1.node_class,nd1.value,nd1.level] == [@st0.id,'column','column_name',2 ]
    nd2 = nd1.context_nodes.create(node_class: 'range', value: 'range_value')
    assert [nd2.context_tree_id,nd2.node_class,nd2.value,nd2.level] == [@st0.id,'range','range_value',3 ]

  end
 
  test "node iterator" do

    nd = @st.context_nodes.create
    nd1 = nd.context_nodes.create( node_class: 'table',value: 't1')
    nd2 = nd.context_nodes.create( node_class: 'table',value: 't2')
    nd11 = nd1.context_nodes.create( node_class: 'column',value: 'c11')
    nd12 = nd1.context_nodes.create( node_class: 'column',value: 'c12')
    nd21 = nd2.context_nodes.create( node_class: 'column',value: 'c21')
    nd22 = nd2.context_nodes.create( node_class: 'column',value: 'c22')
    nd221 = nd22.context_nodes.create( node_class: 'range', value: 'r221') 
    nd23 = nd2.context_nodes.create( node_class: 'column',value: 'c23')
    
    t =''
    nd.each { |n | p (t + ''+ n.value); t = t + n.value }
  end

  test 'fixtures' do
    assert context_nodes(:where_point_t).node_class == 'table'
    assert context_nodes(:where_point_f1).context_tree == context_trees(:where_point)
    assert context_nodes(:where_point_f4).value == 'f4'
  end

  test 'shadow?' do
    assert context_nodes(:one_1).shadow? context_nodes(:one_2) 
    assert_not context_nodes(:one_1).shadow? context_nodes(:one_3) 
    assert context_nodes(:three_0).shadow? context_nodes(:three_1) 
    assert_not context_nodes(:three_0).shadow? context_nodes(:three_f) 
  end

  test 'shadow' do
      original = context_nodes(:one_1)
      shadow = original.shadow
      assert_not original.equal? shadow
      assert original.shadow? shadow
      original = context_nodes(:three_0)
      shadow = original.shadow
      assert_not original.equal? shadow
      assert original.shadow? shadow
  end
end
