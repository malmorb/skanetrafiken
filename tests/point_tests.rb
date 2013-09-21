#!/opt/local/bin/ruby1.9
$:.unshift File.dirname(__FILE__)
require "test_helper"

class PointTests < Test::Unit::TestCase
  def setup
    @malmo = Skanetrafiken::Point.new('malmö C',80000,:stop)
    @another_malmo = Skanetrafiken::Point.new('malmö C',80000,:stop)
    @landskrona = Skanetrafiken::Point.new('landskrona',82000,:stop)
  end
  def test_are_not_equal
      assert_not_equal(@malmo, @landskrona)
  end
  def test_are_equal
      assert_equal(@malmo, @another_malmo)
  end
end
