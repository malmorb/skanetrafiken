# encoding: utf-8
$:.unshift File.dirname(__FILE__)
require "test_helper"

class GetDepartureArrivalParserTests < Test::Unit::TestCase
  def setup
    @g = Skanetrafiken::GetDepartureArrival.new
    @file = GetDepartureArrival.new.get_station_results
  end
  def test_get_lines
    lines = @g.get_lines(@file)
    expected = [
      {:name=> '5', :no=> '5', :journey_date_time=> DateTime.parse('2012-02-09T08:39:00'), :is_timing_point=> 'true', :stop_point=> 'E', :line_type_id=> '1', :line_type_name=> 'Stadsbuss', :towards=> 'Hyllie'},
      {:name=> '2', :no=> '2', :journey_date_time=> DateTime.parse('2012-02-09T08:40:00'), :is_timing_point=> 'true', :stop_point=> 'D', :line_type_id=> '1', :line_type_name=> 'Stadsbuss', :towards=> 'Västra hamnen via Kockum Fritid'},
      {:name=> '35', :no=> '35', :journey_date_time=> DateTime.parse('2012-02-09T08:40:00'), :is_timing_point=> 'true', :stop_point=> 'F', :line_type_id=> '1', :line_type_name=> 'Stadsbuss', :towards=> 'Östra Hamnen'},
      {:name=> '3', :no=> '3', :journey_date_time=> DateTime.parse('2012-02-09T08:41:00'), :is_timing_point=> 'true', :stop_point=> 'D', :line_type_id=> '1', :line_type_name=> 'Stadsbuss', :towards=> 'Ringlinjen via Erikslust'},
      {:name=> 'Öresundståg', :no=> '805', :journey_date_time=> DateTime.parse('2012-02-09T08:42:00'), :is_timing_point=> 'true', :stop_point=> '1', :line_type_id=> '16', :line_type_name=> 'Öresundståg', :towards=> 'Nivå'}
      ].map{ |l| Skanetrafiken::Line.new(l) }
    assert_equal expected, lines[0,5]
  end
end

