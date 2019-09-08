class TokenTray 
  attr_accessor :state,:content

  def receive token
    if state?
      self.content.push token
    end
  end

  def open
    @state= true    
  end

  def close
    @state= false    
  end

  def state?
    return state
  end

private
  def initialize
    @content = []
    @state = false;  
  end
  

end

