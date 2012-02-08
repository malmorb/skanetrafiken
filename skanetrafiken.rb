require "rubygems"
#require 'URI'
require 'net/http'

class Skanetrafiken
  def getxml(url)
     uri = URI(url)
     return Net::HTTP.get_response(uri).body 
  end
  def getStations(name)
    stationurl = QueryStationUrl.new
    lsx = getxml(stationurl.render(name)) 
    return QueryStationParser.new( lsx).stations()
  end
  def getTimes(nameFrom, nameTo, time)
    from = getStations(nameFrom)[0]
    to = getStations(nameTo)[0]
    journeyurl = GetJourneyUrl.new
    lsx = getxml(journeyurl.render(from,to,time))
    return GetJourneyParser.new(lsx).gettimes()
  end
end


class QueryStationUrl
  def render(name)
    return "http://www.labs.skanetrafiken.se/v2.2/querystation.asp?inpPointfr=#{URI.escape(name)}"
  end
end

class GetJourneyUrl
  def render(selPointFr,selPointTo,lastStartD)
    lastStart = lastStartD.strftime("%Y-%m-%d %H:%M")
    to = URI.escape("#{selPointTo[:name]}|#{selPointTo[:id]}|#{selPointTo[:type]}")
    from = URI.escape("#{selPointFr[:name]}|#{selPointFr[:id]}|#{selPointFr[:type]}")
    return ["http://www.labs.skanetrafiken.se/v2.2/resultspage.asp?cmdaction=next",
    "selPointFr=#{from}",
    "selPointTo=#{to}",
    "LastStart=#{URI.escape(lastStart)}"].join("&")
  end
end

require 'rexml/document'

class GetJourneyParser
  def initialize(html)
      @doc = REXML::Document.new(html)
  end
  def gettimes()
      el = []
      v = @doc.elements["soap:Envelope/soap:Body/GetJourneyResponse/GetJourneyResult/Journeys"]
      v.elements.each("Journey") { |j|
          el.push(j.elements["DepDateTime"].text)
      }
      return el
  end
end

class QueryStationParser
  
  def initialize(html)
      @doc = REXML::Document.new(html)
      @types ={ "STOP_AREA" => 0, "ADDRESS" => 1, "POI" => 2, "UNKNOWN" => 3}
  end
  def parseType(val)
    return @types[val]
  end
  def stations()
      el = []
      v = @doc.elements["soap:Envelope/soap:Body/GetStartEndPointResponse/GetStartEndPointResult/StartPoints"]
      v.elements.each("Point") { |j|
          el.push({
            :id=>j.elements["Id"].text,
            :name=>j.elements["Name"].text,
            :type=>parseType(j.elements["Type"].text)
          })
      }
      return el
  end
end