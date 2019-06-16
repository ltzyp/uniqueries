class SqlTree < ApplicationRecord
  has_many :sql_nodes 

  def self.all_node_classes
    [:peer,:foreign,:where,:table,:column,:range,:string,:number,:date,:order,:position]
  end

  self.all_node_classes do | node_class |
  end

  def each &block
    sql_nodes.each do | n |
        block.call n
        n.each_node &block
    end
  end 

end
