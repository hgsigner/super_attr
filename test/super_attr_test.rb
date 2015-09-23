require 'test_helper'
require 'super_attr/attr'

describe "SuperAttr:Attr" do

	class Thing
		include SuperAttr::Attr

		super_attr :my_int, type: Integer, required: true
		super_attr :my_string, type: String, required: true
		super_attr :my_hash, type: Hash

		def initialize(args={})
			Thing.init_super_attrs(args, self)
		end

	end

	it "inits without any required attribute" do
		err = -> { Thing.new() }.must_raise StandardError
		err.message.must_equal 'Required attributes: my_int, my_string'
	end

	it "inits without required attribute :my_int" do
		err = -> { Thing.new(my_string: "foo") }.must_raise StandardError
		err.message.must_equal 'Required attributes: my_int'
	end

	it "sets the wrong type for attribute" do
		err = -> { Thing.new(my_int: "foo", my_string: 20, my_hash: "foo") }.must_raise StandardError
		err.message.must_equal 'The value for my_int is not a type Integer'
	end

	it "has the right types" do
		t = Thing.new(my_int: 20, my_string: "foo", my_hash: {name: "foo"})
		t.my_int.must_be_kind_of Integer
		t.my_string.must_be_kind_of String
		t.my_hash.must_be_kind_of Hash
	end

end
