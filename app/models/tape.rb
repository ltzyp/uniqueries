class Tape < Syntaxtree
  belongs_to :trunk,foreign_key: :parent_id
  has_many :ribbons , foreign_key: :parent_id

  def build_children tokens
    tokens.each { |e| ribbons.build text: e.first }
  end

  def template
    return /(.+?)(\,|$)/
  end
end;
