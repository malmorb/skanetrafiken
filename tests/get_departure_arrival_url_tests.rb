# encoding: utf-8
$:.unshift File.dirname(__FILE__)
require "test_helper"

class GetDepartureArrivalUrlTests < Test::Unit::TestCase
  def setup
    @c = Skanetrafiken::GetDepartureArrival.new
    @malmo = Skanetrafiken::Point.new({:name=>'malmö C',:id=>80000,:type=>:stop})
  end
  def test_it_can_render
    rurl = "http://www.labs.skanetrafiken.se/v2.2/stationresults.asp?selPointFrKey=80000"
    assert_equal(rurl, @c.render_url(@malmo))
  end
  def test_can_parse_url
    URI.parse(@c.render_url(@malmo))
  end
end
