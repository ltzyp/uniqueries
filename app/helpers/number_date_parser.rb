class NumberDateParser
  TOKENS_SEPARATOR = '.'
  MARK_PREFIX='%'
  attr_accessor :input,:value,:tokens
  attr_reader :registers

  class Formatter
    def pattern; '%02d'; end
    def process(value,state)
      i =  value.to_i
      if (i.zero?)
         i = send state[:zero_handler] 
      end 
      i
    end
    def printv(value,output)  
      output.gsub!(mark,format(pattern,value))
    end
    def mark; MARK_PREFIX+mark_char; end
    def min_value; 0; end; 
    def zero_default; min_value; end;
    def sysdate_default; Time.now.strftime(mark).to_i; end;
  end
  Formatters = [Formatter]*6

  class Register
    attr_accessor :token,:formatter,:value
    def initialize(hash)
      hash.each { |k,v| instance_variable_set("@#{k}",v) unless v.nil? }
    end
    def process; self.value= token.to_i; end
  end

  def initialize( string)
    @input= string
    @tokens = []
  end

  def convert
    build_tokens
    build_registers
    process
  end 

  def to_SQLite
    value.strftime"datetime('%Y-%m-%d-%H-%M-%S')"
  end
private
  def build_tokens
    @tokens= input.split TOKENS_SEPARATOR
  end

  def build_registers
    @registers = []
    tokens.zip(Formatters)  do | a |
      registers << Register.new(token: a.first, formatter: a.last )
    end
  end

  def process
    a = registers.map{|e | e.process; e.value}
    @value = DateTime.new *a
  end
end
