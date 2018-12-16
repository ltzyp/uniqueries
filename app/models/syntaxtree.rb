class Syntaxtree < ApplicationRecord
  belongs_to :parent, optional: true

  def create_children
    begin
      parse
      save
    rescue Exception=> e
      p e
    end
  end
 
  def parse
      tokens= preParse
      build_children tokens
  end 

  def template
    fail NotImplementedError
  end
  
  def === obj
    text=== obj.to_s
  end

private
  def  preParse
    sc = text.scan self.template
    return sc
  end

  def log(e)
  end
end
