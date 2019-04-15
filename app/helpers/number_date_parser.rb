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
    def mark; MARK_PREFIX+self.class.mark_char; end
    def min_value; 0; end; 
    def zero_default; min_value; end;
    def sysdate_default; Time.now.strftime(mark).to_i; end;
  end

  
  @@formatters = [ :Year,:month,:day,:Hour,:Minute,:Second].inject( []) do  | s, sym |
     s << ( self.class_eval <<-CLASS_DEF
      class #{sym.to_s.capitalize} < Formatter
        def self.mark_char; '#{sym.to_s.first}'; end       
        def self.min_value; 1; end
        self
      end
     CLASS_DEF
    )
  end
#  Formatters = [Formatter]*6
  def self.formatters; @@formatters; end

  class Register
    attr_accessor :token,:formatter,:value
    def initialize(hash)
      hash.each { |k,v| instance_variable_set("@#{k}",v) unless v.nil? }
    end
    def process(state)
      if !token.blank?
        res= token.to_i
      else
        p self.formatter
        p state
        res=formatter.send state[:zero_handler]
      end 
      self.value=res
    end
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
    tokens.zip(self.class.formatters)  do | a |
p "formatters "+ a.first.to_s+a.last.to_s
      registers << Register.new(token: a.first, formatter: a.last.new )
    end
  end

  def process
    state= {zero_handler: :sysdate_default}
    a = registers.map do |e | 
      e.process(state);
      state[:zero_handler]=:zero_default if e.value.nonzero?
      e.value;
    end
    @value = DateTime.new *a
  end
end
