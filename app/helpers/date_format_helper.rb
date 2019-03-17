class DateLanguageBasic
MARK_PREFIX='%'
  class Formatter
    def pattern; '%02d'; end
    def printv(value,output)

      output.gsub!(MARK_PREFIX+mark,format(pattern,value))
    end
  end

  class Year < Formatter
    def mark; 'Y'; end
    def pattern; '%d'; end
  end

  class Month < Formatter
    def mark; 'M'; end
  end

  class Day < Formatter
    def mark; 'D'; end
  end

  class Hour < Formatter
    def mark; 'H'; end
  end
  
  class Minute < Formatter
    def mark; 'I'; end
  end

  class Second < Formatter
    def mark; 'S'; end
  end

  def self.formatters
    [Year,Month,Day,Hour,Minute,Second]
  end
  def formatters; self.class.formatters.collect{|c| c.new }; end

  def pattern
    ''
  end

end

class DateLanguageSQLite < DateLanguageBasic
  def pattern
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
         languageClass = string.classify.constantize
      rescue
         languageClass = (p 'DateLanguage'+string.capitalize).classify.constantize 
      end
      @@date_language = languageClass.new
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
    output= date_language.pattern
    p date_language
    p output
    registers.each{ | r | r.formatter.printv( r.value,output )}
    output
  end
end
