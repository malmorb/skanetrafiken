#!/opt/local/bin/ruby1.9
$:.unshift File.dirname(__FILE__)
require "test_helper"

class GetJourneyTests < Test::Unit::TestCase
  def setup
    @file = GetJourney.new.get_resultspage
    @g = Skanetrafiken::GetJourney.new
  end
  
  def test_can_get_times
    times = @g.get_times(@file)
    assert_equal ["2012-02-07T16:39:00",
      "2012-02-07T16:46:00",
      "2012-02-07T17:00:00",
      "2012-02-07T17:08:00",
      "2012-02-07T17:14:00"
      ], times
  end
end

