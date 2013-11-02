# encoding: utf-8
$:.unshift File.dirname(__FILE__)
require 'test_helper'

class QueryStationParserTests < Test::Unit::TestCase
  def test_can_get_stations
    file = GetStartEndPoint.new.get_querystation
    stations = Skanetrafiken::QueryStation.new.get_stations(file)
    res = [{ name: 'Malmö C', id: '80000' },
     { name: 'Malmö Södervärn', id: '80120' },
     { name: 'Malmö Triangeln', id: '80140' },
     { name: 'Malmö Hyllie', id: '80040' },
     { name: 'Malmö Värnhem', id: '80110' },
     { name: 'Malmö Persborg', id: '80682' },
     { name: 'Malmö Östervärn', id: '80201' },
     { name: 'Malmö Svågertorp', id: '80580' },
     { name: 'Malmö Konserthuset', id: '80118' },
     { name: 'Malmö Gustav Adolfs torg', id: '80100' },
     { name: 'Malmö Ön', id: '80338' },
     { name: 'Malmö Höja', id: '80813' },
     { name: 'Malmö Arena', id: '80039' },
     { name: 'Malmö Holma', id: '80500' },
     { name: 'Malmö Högbo', id: '80324' }].map do |item|
      item[:type] = :stop
      Skanetrafiken::Point.new(item)
    end
    assert_equal res, stations
  end
end
