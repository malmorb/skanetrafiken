# encoding: utf-8
module Skanetrafiken

  $point_indexes = [:stop, :address, :poi, :unknown]

  class Point
    attr_reader :name, :id, :type

    def initialize dic
      self.class.properties.each{ |key|
         val = dic[key]
         instance_variable_set("@#{key.to_s}", val)
      }
    end

    def self.properties
      [:name, :id, :type]
    end

    def ==(another_point)
      Line.properties.map{ |key|
        k = "@#{key.to_s}"
        instance_variable_get(k) == another_point.instance_variable_get(k)
      }.inject(true){ |result, element| result and element }
    end

    def render()
      idx = $point_indexes.index(@type)
      "#{@name}|#{@id}|#{idx}"
    end
  end

end
