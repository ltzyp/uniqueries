class Columnname < Syntaxtree
  belongs_to :ribbon ,foreign_key: :parent_id

  def build_children token
  end
 
  def template
    return nil
  end
end;
