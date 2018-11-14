class Qsource < Qtext
  belongs_to :qline , foreign_key: :parent_id
  def template
    return /(.*)\:(.*)/
  end
end;
