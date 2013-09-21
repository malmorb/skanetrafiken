module Skanetrafiken
  class GetDepartureArrival
    def initialize opts={}
        @xmltojson = opts[:xml_to_json] || XmlToJson.new()
    end
    def render_url(point)
      return "http://www.labs.skanetrafiken.se/v2.2/stationresults.asp?selPointFrKey=#{point.id}"
    end
    
    def get_lines(html)
      doc = REXML::Document.new(html)
      el = []
      v = doc.elements["soap:Envelope/soap:Body/GetDepartureArrivalResponse/GetDepartureArrivalResult/Lines"]
      v.elements.each("Line") { |j|
        dic = {}
        $properties_line.each{ |key,value|
          xval = j.elements[value].text
          dic[key] = xval
          #puts "#{key} = #{value} = #{xval}"
        }
        #deviation 
        info = j.elements["RealTime/RealTimeInfo"]
        if info 
          dic[:dep_time_deviation] = info.elements["DepTimeDeviation"].text
          dic[:dep_deviation_affect] = info.elements["DepDeviationAffect"].text
        end
        #<RealTime>
        #<RealTimeInfo>
        #<DepTimeDeviation>40</DepTimeDeviation>
        #<DepDeviationAffect>CRITICAL</DepDeviationAffect>
        
        #puts dic.map{ |k,v| "#{k}, #{v}" }.join('; ')
        el.push(Line.new(dic))
      }
      return el
    end
    
    def json(html)
      doc = REXML::Document.new(html)
      xml = doc.elements["soap:Envelope/soap:Body/GetDepartureArrivalResponse/GetDepartureArrivalResult/Lines"]
      return @xmltojson.convert( xml.to_s )
    end
  end
end