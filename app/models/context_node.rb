class ContextNode < ApplicationRecord
  belongs_to :context_tree
  belongs_to :parent_node, class_name: 'ContextNode', foreign_key: :parent_id, optional: true

  has_many  :context_nodes, foreign_key: :parent_id 
  serialize :context


  after_initialize do
    self.context||=  {} 
    copy_context_from_parent
  end

  def each &block 
    return unless block
    context_nodes.each do |n|  
      block.call(n)
      n.each( &block ) 
    end
  end

  def level
    return 0 unless parent_node
    return  parent_node.level + 1     
  end

  def add_context hash
    self.context.merge!( hash||{} )
  end

private


  def  copy_context_from_parent
    if parent_node
      self.context_tree= self.parent_node.context_tree 
      self.context.merge!( parent_node.context||{})
    end
  end
end
