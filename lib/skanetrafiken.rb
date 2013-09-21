#!/opt/local/bin/ruby1.9
require "rubygems"
require 'net/http'
require 'rexml/document'
require "crack"
require "json"
Dir[File.join(File.dirname(__FILE__),'skanetrafiken','*.rb')].each {|file| require file }
module Skanetrafiken

  class XmlToJson
    def convert(xml)
      return Crack::XML.parse(xml).to_json
    end
  end
  
  $point_string_totype ={ "STOP_AREA" => :stop, "ADDRESS" => :address, "POI" => :poi, "UNKNOWN" => :unknown}
  
  class UriHelper
    def parameters_from_hash(hash)
      return hash.map{ |key,value| 
            "#{key.to_s}=#{URI.escape(value.to_s)}" 
        }.join("&")
    end
  end

  $properties_line = {:name=>'Name',:no=>'No',:journey_date_time=>'JourneyDateTime',:is_timing_point=>'IsTimingPoint',\
    :stop_point=>'StopPoint',:line_type_id=>'LineTypeId',:line_type_id=>'LineTypeId',:line_type_name=>'LineTypeName',\
    :towards=>'Towards'}
  $properties_line_realtime ={:dep_time_deviation => "DepTimeDeviation",:dep_deviation_affect=>"DepDeviationAffect"}  
  class LineRealTime
    attr_reader :dep_time_deviation, :dep_deviation_affect
  end
  

end
