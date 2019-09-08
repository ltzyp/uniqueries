require 'test_helper'

class ContextTreeStreamReader < ActiveSupport::TestCase
  setup do
    class ContextNodeStub
      attr_accessor  :context_nodes
      attr_accessor  :parent
      attr_accessor  :value
      def initialize (parent_,value_ ) ; @parent=parent_; @value=value_ ; end
      def path
       ( parent ?  parent.path : "") + self.value 
      end
    end
    
    @sns  = ContextNodeStub.new( nil, "s0")
    @sns1 = ContextNodeStub.new(@sns, "s1")
    @sns2 = ContextNodeStub.new(@sns, "s1")
    @sns11 = ContextNodeStub.new( @sns1, "s11")
    @sns12 = ContextNodeStub.new( @sns1, "s12")
    @sns21 = ContextNodeStub.new( @sns2, "s21")
    @sns22 = ContextNodeStub.new( @sns2, "s22")
    @sns.context_nodes= [@sns1,@sns2]
    @sns1.context_nodes= [@sns11,@sns12]
    @sns2.context_nodes= [@sns21,@sns22]

    @sr = ContextTreeStreamReader.new( @sns)
  end

  test "tree stream reader active path" do

skip "tree stream reader active path"

    @sr.next_node (1)
    assert @sr.active_node.path =="s0s1"
  end
end
