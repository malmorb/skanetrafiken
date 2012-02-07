require "../skanetrafiken"

require 'test/unit'
require "rubygems"

class GetJourneyUrlTests < Test::Unit::TestCase
  def setup
    @url = GetJourneyUrl.new
  end
  def test_it_can_render
    rurl = "http://www.labs.skanetrafiken.se/v2.2/resultspage.asp?cmdaction=next&selPointFr=malm%C3%B6%20C|80000|0&selPointTo=landskrona|82000|0&LastStart=2012-02-07%2016:38"
    assert_equal(rurl, @url.render(
      {:name=>'malmö C',:id=>80000,:type=>0},
      {:name=>'landskrona',:id=>82000,:type=>0},
      Time.utc(2012,2,7,16,38)))
  end
  def test_can_parse_url
    URI.parse(@url.render(
      {:name=>'malmö C',:id=>80000,:type=>0},
      {:name=>'landskrona',:id=>82000,:type=>0},
      Time.utc(2012,2,7,16,38)))
  end
end

class QueryStationUrlTests < Test::Unit::TestCase
  def setup
    @url = QueryStationUrl.new
  end
  def test_it_can_render
    rurl = "http://www.labs.skanetrafiken.se/v2.2/querystation.asp?inpPointfr=lund%20s%C3%B6dra%20tpl"
    assert_equal(rurl, @url.render("lund södra tpl"))
  end
  def test_can_parse_url
    URI.parse(@url.render("lund södra tpl"))
  end
end


class GetJourneyParserTests < Test::Unit::TestCase
  def test_can_get_times
    File.open("GetJourney_resultspage.xml", "r") { |infile|
      @parser = GetJourneyParser.new(infile.read)
    }
    times = @parser.gettimes()
    assert_equal ["2012-02-07T16:39:00",
      "2012-02-07T16:46:00",
      "2012-02-07T17:00:00",
      "2012-02-07T17:08:00",
      "2012-02-07T17:14:00"
      ], times
  end
end
# 

class GetJourneyParserTests < Test::Unit::TestCase
  def test_can_get_stations
    File.open("GetStartEndPoint_querystation.xml", "r") { |infile|
      @qparser = QueryStationParser.new(infile.read)
    }
    res = [{:type=>0, :name=>"Malmö C", :id=>"80000"},
     {:type=>0, :name=>"Malmö Södervärn", :id=>"80120"},
     {:type=>0, :name=>"Malmö Triangeln", :id=>"80140"},
     {:type=>0, :name=>"Malmö Hyllie", :id=>"80040"},
     {:type=>0, :name=>"Malmö Värnhem", :id=>"80110"},
     {:type=>0, :name=>"Malmö Persborg", :id=>"80682"},
     {:type=>0, :name=>"Malmö Östervärn", :id=>"80201"},
     {:type=>0, :name=>"Malmö Svågertorp", :id=>"80580"},
     {:type=>0, :name=>"Malmö Konserthuset", :id=>"80118"},
     {:type=>0, :name=>"Malmö Gustav Adolfs torg", :id=>"80100"},
     {:type=>0, :name=>"Malmö Ön", :id=>"80338"},
     {:type=>0, :name=>"Malmö Höja", :id=>"80813"},
     {:type=>0, :name=>"Malmö Arena", :id=>"80039"},
     {:type=>0, :name=>"Malmö Holma", :id=>"80500"},
     {:type=>0, :name=>"Malmö Högbo", :id=>"80324"}]
    assert_equal res, @qparser.stations()
  end
end