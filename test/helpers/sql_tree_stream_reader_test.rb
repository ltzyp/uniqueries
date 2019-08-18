require 'test_helper'

class SqlTreeStreamReader < ActiveSupport::TestCase
  setup do
    class SqlNodeStub
      attr_accessor  :sql_nodes
      attr_accessor  :parent
      attr_accessor  :value
      def initialize (parent_,value_ ) ; @parent=parent_; @value=value_ ; end
      def path
       ( parent ?  parent.path : "") + self.value 
      end
    end
    
    @sns  = SqlNodeStub.new( nil, "s0")
    @sns1 = SqlNodeStub.new(@sns, "s1")
    @sns2 = SqlNodeStub.new(@sns, "s1")
    @sns11 = SqlNodeStub.new( @sns1, "s11")
    @sns12 = SqlNodeStub.new( @sns1, "s12")
    @sns21 = SqlNodeStub.new( @sns2, "s21")
    @sns22 = SqlNodeStub.new( @sns2, "s22")
    @sns.sql_nodes= [@sns1,@sns2]
    @sns1.sql_nodes= [@sns11,@sns12]
    @sns2.sql_nodes= [@sns21,@sns22]

    @sr = SqlTreeStreamReader.new( @sns)
  end

  test "tree stream reader active path" do

skip "tree stream reader active path"

    @sr.next_node (1)
    assert @sr.active_node.path =="s0s1"
  end
end
