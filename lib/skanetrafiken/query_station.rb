module Skanetrafiken
  
  $point_string_totype ={ "STOP_AREA" => :stop, "ADDRESS" => :address, "POI" => :poi, "UNKNOWN" => :unknown}

  class QueryStation
    def initialize opts={}
        @xmltojson = opts[:xml_to_json] || XmlToJson.new()
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
    def json(html)
      doc = REXML::Document.new(html)
      xml = doc.elements["soap:Envelope/soap:Body/GetStartEndPointResponse/GetStartEndPointResult/StartPoints"]
      return @xmltojson.convert( xml.to_s )
    end
  end
end