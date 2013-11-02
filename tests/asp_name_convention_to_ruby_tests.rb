# encoding: utf-8
$:.unshift File.dirname(__FILE__)
require 'test_helper'

class AspNameConventionToRubyTests < Test::Unit::TestCase
  DATA = {
    Name: 'name',
    No: 'no',
    JourneyDateTime: 'journey_date_time',
    IsTimingPoint: 'is_timing_point',
    StopPoint: 'stop_point',
    LineTypeId: 'line_type_id',
    LineTypeName: 'line_type_name',
    Towards: 'towards'
  }
  def test_get_lines
    DATA.each_pair do |value, expected|
      got = Skanetrafiken::to_ruby_convention(value.to_s)
      assert_equal expected, got
    end
  end
end

