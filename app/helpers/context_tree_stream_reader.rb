class ContextTreeStreamReader
  attr_reader  :indents
  attr_accessor  :active_page
  
  def self.on( context_tree)
    nt = self.new
    nt.active_page= context_tree.context_node
    nt 
  end

  def initialize
    @indents =[0]
  end

  def next_page indent
    unless indent >= self.indents.last
      indents.pop
      self.active_page= active_page.first.parent
    end
    if indent>indents.last
      indents.push indent
      self.active_page= self.active_page.context_nodes.last
    end
    return @active_page 
  end
    
end
