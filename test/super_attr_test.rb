require 'test_helper'
require 'super_attr/attr'

describe "SuperAttr:Attr" do

	class Thing
		include SuperAttr::Attr

		super_attr :my_int, type: Integer, required: true 

		# def initialize(args={})
		# 	my_int = args[:my_int]
		# end

	end

	it "set the wrong type for attr" do
		t = Thing.new()
		err = -> {t.my_int = "foo"}.must_raise StandardError
		err.message.must_equal 'The value for my_int is not a type Integer'
	end

end
