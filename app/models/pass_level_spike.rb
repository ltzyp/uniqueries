class SyntaxTree 

  def
     tokens = split_tokens text
     objects = self.parser_class.convert tokens, type: self.scalar_type
     if !self.scalar_type
      create_nodes objects
     end
     save
  end

end

class BaseParser

  def convert(tokens,options= {})
    build_registers tokens
    ret= convert_registers
    if options[:type]= :scalar 
      ret= assembly_value  # ??
    end 
    ret
  end
end

# should convert return  value or values? 
# where must we do assembling? 
