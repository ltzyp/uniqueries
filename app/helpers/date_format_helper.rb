class DateLanguageAbstract

  class Formatter
    def template; '%02d'; end
    def self.printv(value,output)
      p signature
      p self.signature                 
      p value                 
      p output
      output.gsub!('%'+signature,format(self.template,value))
    end
  end

  class Year < Formatter
    def self.signature; 'Y'; end
    def self.template; '%d'; end
  end

  class Month < Formatter
    def self.signature; 'M'; end
  end

  class Day < Formatter
    def self.signature; 'D'; end
  end

  class Hour < Formatter
    def self.signature; 'H'; end
  end
  
  class Minute < Formatter
    def self.signature; 'I'; end
  end

  class Second < Formatter
    def self.signature; 'S'; end
  end

  def self.formatters
    [Year,Month,Day,Hour,Minute,Second]
  end
  def self.date_template
    ''
  end

end

class DateLanguageSQLite < DateLanguageAbstract
  def self.date_template
    "datetime('%Y-%M-%D-%H-%I-%S')"
  end
end

class DateFormatHelper
 

  TRUNCATE = '!'  
  SEPARATOR = '.'

  attr_reader :registers, :formatters;
  
  def self.setDateLanguage(object)
    begin
      string= object.to_s
      begin
         @@date_language = string.classify.constantize
      rescue
         @@date_language = (p 'DateLanguage'+string.capitalize).classify.constantize 
      end
    rescue
      raise 'failed to set date language for:  '+string
    end
     
  end

  def date_language; @@date_language; end

  class Register
    attr_accessor :input,:formatter,:value
    def initialize(hash)
      hash.each { |k,v| instance_variable_set("@#{k}",v) unless v.nil? }
    end
  end

  def self.process(string)
    tokens = string.split(SEPARATOR)
    raise 'too short Date' if tokens.size <2
    self.new(tokens).process.to_s
  end

  def initialize( tokens)
    @registers = []
    
    date_language.formatters.zip(tokens) do | a |
      registers << Register.new( formatter: a.first, value: a.last )
    end
  end

  def process
    registers.each{| r | r.value= r.formatter.process r.input }
    self
  end
  def print
    output= date_language.date_template
    p date_language
    p output
    registers.each{ | r | r.formatter.printv( r.value,output )}
    output
  end
end
