
require 'rubygems'
require 'sinatra'
require 'skanetrafiken'

get '/' do
  "test"
end

get '/lundsodra' do
  s = Skanetrafiken.new
  k = s.getTimes("lund södra tpl","konserthuset",Time.now)
  "#{k}"
end