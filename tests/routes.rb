#!/opt/local/bin/ruby1.9
require 'rubygems'
require 'sinatra'
require 'app'
get '/' do
  "test"
end

get '/lundsodra' do
  s = App.new
  k = s.get_times("lund södra tpl","konserthuset",Time.now)
  "#{k}"
end