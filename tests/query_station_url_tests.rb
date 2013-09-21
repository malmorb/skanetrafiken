#!/opt/local/bin/ruby1.9
$:.unshift File.dirname(__FILE__)
require "test_helper"

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

