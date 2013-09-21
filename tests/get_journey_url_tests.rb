#!/opt/local/bin/ruby1.9
$:.unshift File.dirname(__FILE__)
require "test_helper"

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
