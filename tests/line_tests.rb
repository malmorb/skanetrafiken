# encoding: utf-8
#!/opt/local/bin/ruby1.9
$:.unshift File.dirname(__FILE__)
require "test_helper"

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
