module Skanetrafiken
  
  $point_indexes = [:stop, :address, :poi, :unknown]
  
  class Point
    def self.properties
      return [:name, :id, :type]
    end
    attr_reader :name, :id, :type
    def initialize dic
      Point.properties.each{ |key|
         val = dic[key]
         instance_variable_set("@#{key.to_s}", val)
      }
    end
    def ==(another_point)
      return Line.properties.map{ |key|
        k = "@#{key.to_s}"
        instance_variable_get(k) == another_point.instance_variable_get(k)
      }.inject(true){ |result, element| result and element }
    end
    def render()
        idx = $point_indexes.index(@type)
       return "#{@name}|#{@id}|#{idx}"
    end    
  end

end