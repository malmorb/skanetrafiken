require "rubygems"
#require 'URI'
require 'net/http'
require 'rexml/document'

module Skanetrafiken
  $point_indexes = [:stop, :address, :poi, :unknown]
  $point_string_totype ={ "STOP_AREA" => :stop, "ADDRESS" => :address, "POI" => :poi, "UNKNOWN" => :unknown}
  
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
       return URI.escape("#{@name}|#{@id}|#{idx}")
    end    
  end
  
  class GetJourney
    def initialize()
    end
    def render_url(pointFrom,pointTo,lastStart)
      lastStartText = lastStart.strftime("%Y-%m-%d %H:%M")
      to = pointTo.render()
      from = pointFrom.render()
      return ["http://www.labs.skanetrafiken.se/v2.2/resultspage.asp?cmdaction=next",
      "selPointFr=#{from}",
      "selPointTo=#{to}",
      "LastStart=#{URI.escape(lastStartText)}"].join("&")
    end
    
    def get_times(html)
        doc = REXML::Document.new(html)
        el = []
        v = doc.elements["soap:Envelope/soap:Body/GetJourneyResponse/GetJourneyResult/Journeys"]
        v.elements.each("Journey") { |j|
            el.push(j.elements["DepDateTime"].text)
        }
        return el
    end
  end

  class QueryStation
  
    def initialize()
    end
    def render_url(name)
      return "http://www.labs.skanetrafiken.se/v2.2/querystation.asp?inpPointfr=#{URI.escape(name)}"
    end
    def get_stations(html)
        doc = REXML::Document.new(html)
        el = []
        v = doc.elements["soap:Envelope/soap:Body/GetStartEndPointResponse/GetStartEndPointResult/StartPoints"]
        v.elements.each("Point") { |j|
            el.push(Point.new(
              j.elements["Name"].text,
              j.elements["Id"].text,
              $point_string_totype[j.elements["Type"].text]
            ))
        }
        return el
    end
  end
end
