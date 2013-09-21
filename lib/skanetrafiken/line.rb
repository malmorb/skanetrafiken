module Skanetrafiken
  class Line
    attr_reader :name,:no,:journey_date_time,:is_timing_point,\
      :stop_point,:line_type_id,:line_type_id,:line_type_name,\
      :towards
    def initialize dic
      $properties_line.each{ |key,value|
         val = dic[key]
         instance_variable_set("@#{key.to_s}", val)
      }
      #puts @name
      #puts dic.map{ |k,v| "#{k}: #{v}" }.join('; ')
    end
    def ==(another)
      return $properties_line.map{ |key,value|
        k = "@#{key.to_s}"
        instance_variable_get(k) == another.instance_variable_get(k)
      }.inject(true){ |result, element| result and element}
    end
    def to_s
      a = []
      $properties_line.each{ |key,value|
        val = instance_variable_get("@#{key.to_s}")
        a.push(":#{key.to_s}=> '#{val}'")
      }
      return a.join(", ")
    end
  end
end