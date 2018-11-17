class Trunk < Syntaxtree
  has_one :tape, foreign_key: :parent_id
  has_one :source, foreign_key: :parent_id

  def template
    return /(.*)\#(.*)/
  end

  def build_children tokens
    build_source text: tokens[1]
    build_tape text: tokens[2]
  end
end;
