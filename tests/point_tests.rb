#!/opt/local/bin/ruby1.9
$:.unshift File.dirname(__FILE__)
require "test_helper"

class PointTests < Test::Unit::TestCase
  def setup
    @malmo = Skanetrafiken::Point.new({:name=>'malmö C',:id=>80000,:type=>:stop})
    @another_malmo = Skanetrafiken::Point.new({:name=>'malmö C',:id=>80000,:type=>:stop})
    @landskrona = Skanetrafiken::Point.new({:name=>'landskrona',:id=>82000,:type=>:stop})
  end
  def test_are_not_equal
      assert_not_equal(@malmo, @landskrona)
  end
  def test_are_equal
      assert_equal(@malmo, @another_malmo)
  end
end
