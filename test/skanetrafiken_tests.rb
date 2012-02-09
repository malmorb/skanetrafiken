require "../skanetrafiken"

require 'test/unit'
require "rubygems"

class PointTests < Test::Unit::TestCase
  def setup
    @malmo = Skanetrafiken::Point.new('malmö C',80000,:stop)
    @another_malmo = Skanetrafiken::Point.new('malmö C',80000,:stop)
    @landskrona = Skanetrafiken::Point.new('landskrona',82000,:stop)
  end
  def test_are_not_equal
      assert_not_equal(@malmo, @landskrona)
  end
  def test_are_equal
      assert_equal(@malmo, @another_malmo)
  end
end


class GetJourneyUrlTests < Test::Unit::TestCase
  def setup
    @getjourney = Skanetrafiken::GetJourney.new
    @malmo = Skanetrafiken::Point.new('malmö C',80000,:stop)
    @landskrona = Skanetrafiken::Point.new('landskrona',82000,:stop)
  end
  def test_it_can_render
    rurl = "http://www.labs.skanetrafiken.se/v2.2/resultspage.asp?cmdaction=next&selPointFr=malm%C3%B6%20C%7C80000%7C0&selPointTo=landskrona%7C82000%7C0&LastStart=2012-02-07%2016:38"
    assert_equal(rurl, @getjourney.render_url(@malmo, @landskrona, Time.utc(2012,2,7,16,38)))
  end
  def test_can_parse_url
    URI.parse(@getjourney.render_url(@malmo, @landskrona,Time.utc(2012,2,7,16,38)))
  end
end

class QueryStationUrlTests < Test::Unit::TestCase
  def setup
    @querystation = Skanetrafiken::QueryStation.new
  end
  def test_it_can_render
    rurl = "http://www.labs.skanetrafiken.se/v2.2/querystation.asp?inpPointfr=lund%20s%C3%B6dra%20tpl"
    assert_equal(rurl, @querystation.render_url("lund södra tpl"))
  end
  def test_can_parse_url
    URI.parse(@querystation.render_url("lund södra tpl"))
  end
end


class GetJourneyParserTests < Test::Unit::TestCase
  def test_can_get_times
    @parser = Skanetrafiken::GetJourney.new
    File.open("GetJourney_resultspage.xml", "r") { |infile|
      @times = @parser.get_times(infile.read)
    }
    assert_equal ["2012-02-07T16:39:00",
      "2012-02-07T16:46:00",
      "2012-02-07T17:00:00",
      "2012-02-07T17:08:00",
      "2012-02-07T17:14:00"
      ], @times
  end
end
# 

class GetJourneyParserTests < Test::Unit::TestCase
  def test_can_get_stations
    querystation = Skanetrafiken::QueryStation.new
    File.open("GetStartEndPoint_querystation.xml", "r") { |infile|
      @stations = querystation.get_stations(infile.read)
    }
    res = [{:name=>"Malmö C", :id=>"80000"},
     {:name=>"Malmö Södervärn", :id=>"80120"},
     {:name=>"Malmö Triangeln", :id=>"80140"},
     {:name=>"Malmö Hyllie", :id=>"80040"},
     {:name=>"Malmö Värnhem", :id=>"80110"},
     {:name=>"Malmö Persborg", :id=>"80682"},
     {:name=>"Malmö Östervärn", :id=>"80201"},
     {:name=>"Malmö Svågertorp", :id=>"80580"},
     {:name=>"Malmö Konserthuset", :id=>"80118"},
     {:name=>"Malmö Gustav Adolfs torg", :id=>"80100"},
     {:name=>"Malmö Ön", :id=>"80338"},
     {:name=>"Malmö Höja", :id=>"80813"},
     {:name=>"Malmö Arena", :id=>"80039"},
     {:name=>"Malmö Holma", :id=>"80500"},
     {:name=>"Malmö Högbo", :id=>"80324"}].map{ |item| Skanetrafiken::Point.new(item[:name],item[:id],:stop) }
    assert_equal res, @stations
  end
end