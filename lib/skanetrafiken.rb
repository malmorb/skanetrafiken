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
    
  class UriHelper
    def parameters_from_hash(hash)
      return hash.map{ |key,value| 
            "#{key.to_s}=#{URI.escape(value.to_s)}" 
        }.join("&")
    end
  end
  
  def self.to_ruby_convention(name)
    return name.split(/(?=[A-Z])/).map do |word|
      word.downcase
    end.join('_')
  end
end
