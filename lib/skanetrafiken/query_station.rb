# encoding: utf-8
module Skanetrafiken

  class QueryStation
    POINT_TO_TYPE = {
      STOP_AREA: :stop,
      ADDRESS: :address,
      POI: :poi,
      UNKNOWN: :unknown
    }

    def initialize opts={}
    end

    def render_url(name)
      "http://www.labs.skanetrafiken.se/v2.2/querystation.asp?inpPointfr=#{URI.escape(name)}"
    end

    def get_stations(html)
      get_stations_raw(html).map do |dic|
        Point.new(dic)
      end
    end

    def get_stations_raw(html)
      doc = REXML::Document.new(html)
      el = []
      v = doc.elements["soap:Envelope/soap:Body/GetStartEndPointResponse/GetStartEndPointResult/StartPoints"]
      v.elements.each("Point") { |j|
          dic = Skanetrafiken::get_values_as_dictionary(j)
          dic[:type] = POINT_TO_TYPE[dic[:type].intern]
          el << dic
      }
      el
    end
  end
end
