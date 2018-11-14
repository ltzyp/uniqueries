class Qline < Qtext
  has_one :qsource, foreign_key: :parent_id
  has_one :qtapestry, foreign_key: :parent_id

  def template
    return /(.*)\#(.*)/
  end

  def build_children tokens
    build_qsource text: tokens[1]
    build_qtapestry text: tokens[2]
  end
end;
