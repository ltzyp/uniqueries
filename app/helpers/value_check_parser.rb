require 'number_date_parser'

class ValueCheckParser < BaseParser

  def self.tokens_separator
    '~'
  end

  def self.for string
    return PointValueCheckParser.new( string) if string.count(tokens_separator).zero?
    return RangeValueCheckParser.new( string)
  end
end

class PointValueCheckParser < ValueCheckParser

end



