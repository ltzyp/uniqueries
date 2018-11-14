class Qtapestry < Qtext
  belongs_to :qline,foreign_key: :parent_id,inverse_of: :qtapestry

  def template
    return /(.*)\:(.*)/
  end
end;
