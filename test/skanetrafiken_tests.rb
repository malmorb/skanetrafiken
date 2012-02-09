#!/opt/local/bin/ruby1.9
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

class LineTests < Test::Unit::TestCase
  def setup
    @no5 = Skanetrafiken::Line.new( {:is_timing_point=> 'true', :stop_point=> 'E', :line_type_id=> '1', :no=> '5', :name=> '5', :journey_date_time=> '2012-02-09T08:39:00'})
    @no2 = Skanetrafiken::Line.new( {:is_timing_point=> 'true', :stop_point=> 'D', :line_type_id=> '1', :no=> '2', :name=> '2', :journey_date_time=> '2012-02-09T08:40:00'})
    @anotherno5 = Skanetrafiken::Line.new( {:is_timing_point=> 'true', :stop_point=> 'E', :line_type_id=> '1', :no=> '5', :name=> '5', :journey_date_time=> '2012-02-09T08:39:00'})
  end
  def test_are_not_equal
      assert_not_equal(@no5, @no2)
  end
  def test_are_equal
      assert_equal(@no5, @anotherno5)
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

class GetDepartureArrivalUrlTests < Test::Unit::TestCase
  def setup
    @c = Skanetrafiken::GetDepartureArrival.new
    @malmo = Skanetrafiken::Point.new('malmö C',80000,:stop)
  end
  def test_it_can_render
    rurl = "http://www.labs.skanetrafiken.se/v2.2/stationresults.asp?selPointFrKey=80000"
    assert_equal(rurl, @c.render_url(@malmo))
  end
  def test_can_parse_url
    URI.parse(@c.render_url(@malmo))
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
  def setup
    @file = File.open("GetStartEndPoint_querystation.xml", "r").read
  end
  def test_json
    json = Skanetrafiken::XmlToJson.new().convert(@file)
    #puts json
  end
  def test_can_get_stations
    querystation = Skanetrafiken::QueryStation.new
    @stations = querystation.get_stations(@file)
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

class GetDepartureArrivalParserTests < Test::Unit::TestCase
  def setup
    @g = Skanetrafiken::GetDepartureArrival.new
    @file = File.open("GetDepartureArrival_stationresults.xml", "r").read
  end
  def test_get_lines
    lines = @g.get_lines(@file)
    #puts lines.join("},\n\n{")
    expected = [
      {:name=> '5', :no=> '5', :journey_date_time=> '2012-02-09T08:39:00', :is_timing_point=> 'true', :stop_point=> 'E', :line_type_id=> '1', :line_type_name=> 'Stadsbuss', :towards=> 'Hyllie'},
      {:name=> '2', :no=> '2', :journey_date_time=> '2012-02-09T08:40:00', :is_timing_point=> 'true', :stop_point=> 'D', :line_type_id=> '1', :line_type_name=> 'Stadsbuss', :towards=> 'Västra hamnen via Kockum Fritid'},
      {:name=> '35', :no=> '35', :journey_date_time=> '2012-02-09T08:40:00', :is_timing_point=> 'true', :stop_point=> 'F', :line_type_id=> '1', :line_type_name=> 'Stadsbuss', :towards=> 'Östra Hamnen'},
      {:name=> '3', :no=> '3', :journey_date_time=> '2012-02-09T08:41:00', :is_timing_point=> 'true', :stop_point=> 'D', :line_type_id=> '1', :line_type_name=> 'Stadsbuss', :towards=> 'Ringlinjen via Erikslust'},
      {:name=> 'Öresundståg', :no=> '805', :journey_date_time=> '2012-02-09T08:42:00', :is_timing_point=> 'true', :stop_point=> '1', :line_type_id=> '16', :line_type_name=> 'Öresundståg', :towards=> 'Nivå'}
      ].map{ |l| Skanetrafiken::Line.new(l) }
    assert_equal expected, lines[0,5]
  end
end

