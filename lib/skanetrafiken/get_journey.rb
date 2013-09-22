module Skanetrafiken
  class GetJourney
    def initialize opts = {}
      @uri = UriHelper.new
    end
    def render_url(pointFrom,pointTo,lastStart)
      lastStartText = lastStart.strftime("%Y-%m-%d %H:%M")
      to = pointTo.render()
      from = pointFrom.render()
      parameters = {
        :cmdaction =>:next,
        :selPointFr =>pointFrom.render(),
        :selPointTo =>pointTo.render(),
        :LastStart =>lastStartText
      }
      return "http://www.labs.skanetrafiken.se/v2.2/resultspage.asp?" + @uri.parameters_from_hash(parameters)
    end
    
    def get_times(html)
        doc = REXML::Document.new(html)
        el = []
        doc.elements["soap:Envelope/soap:Body/GetJourneyResponse/GetJourneyResult/Journeys"]\
        .elements.each("Journey") { |j|
            el.push(j.elements["DepDateTime"].text)
        }
        return el
    end
  end
end