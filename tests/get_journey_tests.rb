# encoding: utf-8
$:.unshift File.dirname(__FILE__)
require 'test_helper'

class GetJourneyTests < Test::Unit::TestCase
  def test_can_get_times
    page = GetJourney.new.get_resultspage
    assert_equal ['2012-02-07T16:39:00',
      '2012-02-07T16:46:00',
      '2012-02-07T17:00:00',
      '2012-02-07T17:08:00',
      '2012-02-07T17:14:00'
      ], Skanetrafiken::GetJourney.new.get_times(page)
  end
end

