# encoding: utf-8
#!/opt/local/bin/ruby1.9
require "rubygems"
require 'net/http'
require 'rexml/document'
require "json"
require 'date'
Dir[File.join(File.dirname(__FILE__),'skanetrafiken','*.rb')].each {|file| require file }
module Skanetrafiken
    
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
  def self.change_type(name, value)
    if name.end_with?('date_time')
      return DateTime.parse(value)
    else
      return value
    end
  end

  def self.get_values_as_dictionary(element)
    dic = {}
    element.elements.each do |e|
      name = Skanetrafiken::to_ruby_convention(e.name)
      if e.text
        value = Skanetrafiken::change_type(name, e.text) 
      else 
        value = Skanetrafiken::get_values_as_dictionary(e)
      end
      sym = name.to_sym
      dic[sym] = value
    end
    return dic
  end
end
