class Trunk < Syntaxtree
  has_one :tape, foreign_key: :parent_id
  has_one :source, foreign_key: :parent_id

  def template
    return /(.+?)#(.*)/
  end

  def build_children tokens
    build_source text: tokens.first[0]
    build_tape text: tokens.first[1]
    tape.parse
  end
end;
