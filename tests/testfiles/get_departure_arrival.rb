class GetDepartureArrival
    def initialize
        @dir = File.dirname(__FILE__)
    end
    def get
        return File.open(File.join(@dir,'GetDepartureArrival.xml'), "r").read
    end
    def get_station_results
        return File.open(File.join(@dir,'GetDepartureArrival_stationresults.xml'), "r").read
    end
    def get_station_results2
        return File.open(File.join(@dir,'GetDepartureArrival_stationresults2.xml'), "r").read
    end
end