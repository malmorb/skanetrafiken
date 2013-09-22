module Skanetrafiken
  class Line
    def self.properties
      return [:name,:no,:journey_date_time,:is_timing_point,\
      :stop_point,:line_type_id,:line_type_id,:line_type_name,\
      :towards]
    end
    attr_reader :name,:no,:journey_date_time,:is_timing_point,\
      :stop_point,:line_type_id,:line_type_id,:line_type_name,\
      :towards
    def initialize dic
      Line.properties.each{ |key|
         val = dic[key]
         instance_variable_set("@#{key.to_s}", val)
      }
    end
    def ==(another)
      return Line.properties.map{ |key|
        k = "@#{key.to_s}"
        instance_variable_get(k) == another.instance_variable_get(k)
      }.inject(true){ |result, element| result and element }
    end
    def to_s
      a = []
      Line.properties.each{ |key|
        val = instance_variable_get("@#{key.to_s}")
        a.push(":#{key.to_s}=> '#{val}'")
      }
      return a.join(", ")
    end
  end
end