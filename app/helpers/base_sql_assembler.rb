class BaseSqlAssembler < OpenStruct
  attr_accessor :data,:template,:conjunction
  def initialize( o )
    @conjunction = ','
    @data = o
    @template = @data[:template] || '' if @data.kind_of? Hash
    if @data.kind_of?( Array) && @data.last.kind_of?(Hash) 
        @conjunction = @data.pop[:conjunction] || @conjunction
    end
  end

  def to_sql_string( o )
    return o.sql_string if o.respond_to? :sql_string    
    return o.value.to_s if o.respond_to? :value
    o.to_s
  end  

  def sql_string
    return template_sql_string if @data.kind_of? Hash
    return iterator_sql_string if @data.kind_of? Array
    to_sql_string(data)
  end

private
 def template_sql_string
    string = template
    @data.each do |k,a | 
      string.gsub!(":"+k.to_s,to_sql_string(a) )
    end
    string
  end

 def iterator_sql_string
    (data.collect{|a| to_sql_string(a)}).join( conjunction)
  end
end
