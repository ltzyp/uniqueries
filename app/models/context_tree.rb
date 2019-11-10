require 'context_tree_stream_reader'
class ContextTree < ApplicationRecord
  has_one :context_node 

  def self.all_node_classes
    [:relation,:peer,:foreign,:where,:table,:column,:range,:string,:number,:date,:order,:position]
  end

  self.all_node_classes do | node_class |
  end

  def self.from_lines stream
  line_template = /(\s*)(\w+)\s*(\w*)/
    st = self.create
    st.create_context_node node_class: 'relation'
    tree_controller= ContextTreeStreamReader.on( st)  
    stream.each_line do  | l |
      tokens = (l.scan line_template).first
      indent =  tokens.first.size
      next_page = tree_controller.next_page(indent)           
p "next_page="+ next_page.inspect
      next_page.context_nodes.create( node_class: tokens[1], value: tokens[2])
    end
    st
  end

  def clean_context
    self.each { | n | p '+++'+ n.to_s; n.context= {} }
  end

  def each &block
    block.call context_node
    context_node.each( &block )     
  end 

  def size
    sz = 0;
    self.each { | n | sz +=1 }
    sz
  end

  def tables
    t = []
    self.each do | n |
      t << n.value if n.node_class == 'table'
    end
    t.join ','
  end

  def depth
    d =0
    self.each { | n | d = [n.level, d].max }
    d
  end

  def predefined_attribute_names
    ["id","created_at","updated_at"]
  end

  def essential_attributes
    self.attributes.except *predefined_attribute_names  
  end

end
