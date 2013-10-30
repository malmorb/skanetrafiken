# encoding: utf-8
$:.unshift File.dirname(__FILE__)
require "test_helper"

class AspNameConventionToRubyTests < Test::Unit::TestCase
  def setup
    @names = ['Name','No','JourneyDateTime','IsTimingPoint','StopPoint','LineTypeId','LineTypeId','LineTypeName','Towards']
  end
  def test_get_lines
    expected = ['name','no','journey_date_time','is_timing_point',\
    'stop_point','line_type_id','line_type_id','line_type_name',\
    'towards']
    got = @names.map do |name|
      Skanetrafiken::to_ruby_convention(name)
    end.to_a
    assert_equal expected, got
  end
end

