require 'base_parser'

class NumberDateParser < BaseParser
  def self.tokens_separator
    '.'
  end 
  def self.for string
    case string.count(tokens_separator)
    when 0..1; return NumberParser.new (string)
    when 2..6; return DateParser.new (string)
    end
    raise 'Cannot parse '+string
  end
 

private

end


class NumberParser < NumberDateParser
  def direct_convert
    @value= @input.to_f
  end

end

