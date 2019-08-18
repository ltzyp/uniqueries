class SqlTreeStreamReader
  attr_reader  :indents
  attr_accessor  :active_page
  
  def self.for( sql_tree)
    self.new( sql_tree.sql_node )
  end

  def initialize sql_node
p initialize
    @indents =[0]
    @active_page = sql_node.sql_nodes
  end

  def next_page indent
    unless indent >= self.indents.last
      indents.pop
      self.active_page= active_page.first.parent
    end
    if indent>indents.last
      indents.push indent
      self.active_page= self.active_page.last.sql_nodes
    end
    return @active_page 
  end
    
end
