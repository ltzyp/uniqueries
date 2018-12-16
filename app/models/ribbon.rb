class Ribbon < Syntaxtree
  belongs_to :tape,foreign_key: :parent_id
  has_one :columnname, foreign_key: :parent_id
  has_many :limits, foreign_key: :parent_id  

  def build_children token
    tokens= token.first
    build_columnname text: tokens[0]
    limits.build text: tokens[1]
    limits.build text: tokens[2]
  end
 
  def template
    return /(\w+)\[(.*)\:(.*)\]/
  end
end;
