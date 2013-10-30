# encoding: utf-8
class GetJourney
    def initialize
        @dir = File.dirname(__FILE__)
    end
    def get
        return File.open(File.join(@dir,'GetJourney.xml'), "r").read
    end
    def get_resultspage
        return File.open(File.join(@dir,'GetJourney_resultspage.xml'), "r").read
    end
end
