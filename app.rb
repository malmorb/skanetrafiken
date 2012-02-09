require 'skanetrafiken'
class HttpGetResponse
  def get_response_body(uri)
    return Net::HTTP.get_response(uri).body
  end
end
class App
  def initialize opts = {}
      @querystation = opts.delete(:query_station) || Skanetrafiken::QueryStation.new
      @getjourney = opts.delete(:get_journey) || Skanetrafiken::GetJourney.new
      @getresponse = opts.delete(:get_response) || HttpGetResponse.new
  end
  def getxml(url)
     uri = URI(url)
     return @getresponse.get_response_body(uri) 
  end
  def get_stations(name)
    xml = getxml(@querystation.render_url(name)) 
    return @querystation.get_stations(xml)
  end
  def get_times(nameFrom, nameTo, time)
    from = get_stations(nameFrom)[0]
    to = get_stations(nameTo)[0]
    xml = getxml(@getjourney.render_url(from,to,time))
    return @getjourney.get_times(xml)
  end
end
