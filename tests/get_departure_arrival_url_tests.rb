#!/opt/local/bin/ruby1.9
$:.unshift File.dirname(__FILE__)
require "test_helper"

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
