module Skanetrafiken
	module StructInitializer
    def initialize *args
      return super unless (args.length == 1 and args.first.respond_to? :each_pair)
      args.first.each_pair do |k, v|
        self[k] = v if members.map {|x| x.intern}.include? k
      end
    end
	end	
end