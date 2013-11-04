# encoding: utf-8
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
        :selPointFr => from,
        :selPointTo => to,
        :LastStart =>lastStartText
      }
      "http://www.labs.skanetrafiken.se/v2.2/resultspage.asp?" + @uri.parameters_from_hash(parameters)
    end

    def get_times(html)
      doc = REXML::Document.new(html)
      el = []
      doc.elements["soap:Envelope/soap:Body/GetJourneyResponse/GetJourneyResult/Journeys"]\
      .elements.each("Journey") { |j|
        el << j.elements["DepDateTime"].text
      }
      el
    end
  end
end
