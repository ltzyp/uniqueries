class SqlPicker 
  attr_accessor :model,:output_class,:trays

  def collect
  end

  def add_tray sym
    trays[sym]= self.output_class.new
    
  end

private
  def initialize
    @trays= Hash.new    
  end
  
end

