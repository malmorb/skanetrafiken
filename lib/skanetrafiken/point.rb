# encoding: utf-8
module Skanetrafiken
  class Point < Struct.new(:name, :id, :type)
    POINT_INDEXES = [:stop, :address, :poi, :unknown]
    include StructInitializer
    
    def render()
      idx = POINT_INDEXES.index(type)
      "#{name}|#{id}|#{idx}"
    end
  end

end
