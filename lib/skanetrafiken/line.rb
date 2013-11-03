# encoding: utf-8
module Skanetrafiken
  class Line
    attr_reader :name,:no,:journey_date_time,:is_timing_point,\
      :stop_point,:line_type_id,:line_type_id,:line_type_name,\
      :towards

    def initialize dic
      self.class.properties.each do |key|
        val = dic[key]
        instance_variable_set("@#{key.to_s}", val)
      end
    end

    def self.properties
      [:name,:no,:journey_date_time,:is_timing_point,\
      :stop_point,:line_type_id,:line_type_id,:line_type_name,\
      :towards]
    end

    def ==(another)
      self.class.properties.map do |key|
        k = "@#{key.to_s}"
        instance_variable_get(k) == another.instance_variable_get(k)
      end.inject(true) { |result, element| result and element }
    end

  end
end
