class Tape < Syntaxtree
  belongs_to :trunk,foreign_key: :parent_id
  has_many :ribbons , foreign_key: :parent_id

  def build_children tokens
p 'build_children: '+tokens.to_s
    tokens.each { |e| p "tokens for ribbon:"+e.first.to_s; ribbons.build text: e.first }
p self.ribbons
  end

  def template
    return /(.+?)(\,|$)/
  end
end;
