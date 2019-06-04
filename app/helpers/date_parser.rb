require 'number_date_parser'

class DateParser < NumberDateParser
  MARK_PREFIX='%'

  class Formatter
    attr_accessor :token,:value,:zero_handler
    def initialize(hash)
      hash.each { |k,v| instance_variable_set("@#{k}",v) unless v.nil? }
    end

    def pattern; '%02d'; end
    def printv(value,output)  
      output.gsub!(mark,format(pattern,value))
    end
    def mark; MARK_PREFIX+self.class.mark_char; end
    def min_value; 0; end; 
    def zero_default; min_value; end;
    def sysdate_default; Time.now.strftime(mark).to_i; end;
    def blank? ; self.token.blank? ; end
    def convert
      if !token.blank?
        res= token.to_i
      else
        res=self.send self.zero_handler
      end 
      self.value=res
    end
 
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
  def self.all_formatter_marks; formatters.map{|e| e.mark_char}.join; end

  def build_registers
    @registers = []
    tokens.zip(self.class.formatters)  do | a |
      registers << a.last.new(token: a.first)
    end
  end

  def convert_registers
   initialized= false
    registers.map do | r |
      r.zero_handler= initialized ? :zero_default : :sysdate_default 
      r.convert 
      initialized ||= !r.blank?
    end
  end



  def assembly_value 
    @value= DateTime.new *(registers.collect{|r| r.value})
  end


  def to_SQLite
    value.strftime"datetime('%Y-%m-%d-%H-%M-%S')"
  end
end
