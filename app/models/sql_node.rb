class SqlNode < ApplicationRecord
  belongs_to :sql_tree
  belongs_to :parent_node, class_name: 'SqlNode', foreign_key: :parent_id, optional: true

  has_many  :sql_nodes, foreign_key: :parent_id 

  after_initialize do
    update_sql_tree_from_parent
  end

  def each &block 
    return unless block
    sql_nodes.each do |n|  
      block.call(n)
      n.each( &block ) 
    end
  end

  def level
    return 0 unless parent_node
    return  parent_node.level + 1     
  end
private


  def  update_sql_tree_from_parent
    self.sql_tree= parent_node.sql_tree if parent_node #; self
  end
end
