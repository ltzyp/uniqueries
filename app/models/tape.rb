class Tape < Syntaxtree
  belongs_to :trunk,foreign_key: :parent_id,inverse_of: :tape

  def template
    return /(.*)\:(.*)/
  end
end;
