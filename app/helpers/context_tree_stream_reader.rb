class ContextTreeStreamReader
  attr_reader  :indents
  attr_accessor  :active_page
  
  def self.on( context_tree)
    self.new( context_tree.context_node )
  end

  def initialize context_node
p initialize
    @indents =[0]
    @active_page = context_node.context_nodes
  end

  def next_page indent
    unless indent >= self.indents.last
      indents.pop
      self.active_page= active_page.first.parent
    end
    if indent>indents.last
      indents.push indent
      self.active_page= self.active_page.last.context_nodes
    end
    return @active_page 
  end
    
end
