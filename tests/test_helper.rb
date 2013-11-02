# encoding: utf-8
$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'skanetrafiken'
require 'test/unit'
Dir[File.join(File.dirname(__FILE__), 'testfiles', '*.rb')].each {|file| require file }
