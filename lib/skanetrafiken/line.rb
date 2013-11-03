# encoding: utf-8
module Skanetrafiken
  class Line < Struct.new(:name,:no,:journey_date_time,:is_timing_point,\
      :stop_point,:line_type_id,:line_type_id,:line_type_name,\
      :towards)

    include StructInitializer

  end
end
