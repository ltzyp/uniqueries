class Ribbon < Syntaxtree
  belongs_to :tape,foreign_key: :parent_id

  def template
    return /(.*)\[(.*)\]/
  end
end;
