module Skanetrafiken
  class GetDepartureArrival
    def initialize opts={}
    end
    def render_url(point)
      return "http://www.labs.skanetrafiken.se/v2.2/stationresults.asp?selPointFrKey=#{point.id}"
    end
    
    def get_lines(html)
      get_lines_raw(html).map do |dic|
        Line.new(dic)
      end
    end
    def get_lines_raw(html)
      doc = REXML::Document.new(html)
      el = []
      v = doc.elements["soap:Envelope/soap:Body/GetDepartureArrivalResponse/GetDepartureArrivalResult/Lines"]
      v.elements.each("Line") { |j|
        el.push(Skanetrafiken::get_values_as_dictionary(j))
      }
      return el
    end
  end
end