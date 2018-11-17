class Syntaxtree < ApplicationRecord
  belongs_to :parent, optional: true

  def parse
    begin
      tokens= preParse
      build_children tokens
      save
    rescue Exception=> e
      log e
    end
  end 

  def template
    fail NotImplementedError
  end
  
  def === obj
    text=== obj.to_s
  end

private
  def  preParse
    return template.match text
  end

  def log(e)
  end
end
