class Source < Syntaxtree
  belongs_to :trunk , foreign_key: :parent_id
  def template
    return /(.*)\:(.*)/
  end
end;
