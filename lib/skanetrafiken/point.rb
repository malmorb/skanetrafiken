module Skanetrafiken
  
  $point_indexes = [:stop, :address, :poi, :unknown]
  
  class Point
    attr_reader :name, :id, :type
    def initialize(name,id,type)
      @name=name
      @id=id
      @type=type
    end
    def ==(another_point)
      self.name == another_point.name && self.id == another_point.id && self.type == another_point.type
    end
    def render()
        idx = $point_indexes.index(@type)
       return "#{@name}|#{@id}|#{idx}"
    end    
  end

end