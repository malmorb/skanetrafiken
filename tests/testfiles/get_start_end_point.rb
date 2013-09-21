class GetStartEndPoint
    def initialize
        @dir = File.dirname(__FILE__)
    end
    def get
        return File.open(File.join(@dir,'GetStartEndPoint.xml'), "r").read
    end
    def get_querystation
        return File.open(File.join(@dir,'GetStartEndPoint_querystation.xml'), "r").read
    end
end
