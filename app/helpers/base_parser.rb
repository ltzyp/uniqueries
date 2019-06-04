class BaseParser 
  attr_accessor :input,:value,:tokens
  attr_reader :registers
  def self.tokens_separator
    nil
  end 
 
  def convert
    if self.class.tokens_separator
      split_tokens
      build_registers
    end
    if registers.empty?
      direct_convert
    else
      convert_registers
      assembly_value
    end
  end 

private

  def initialize( string)
    @input= string
    @tokens = []
    @registers = []
  end

  def build_registers
    []
  end

  def split_tokens
    @tokens= input.split self.class.tokens_separator
  end

  def convert_registers
    registers.each{ |r| r.convert} 
  end

  def assembly_value
    self.value=registers.sum { |r| r.value } 
  end
  
  def direct_convert
    @value= input
  end
  
end

