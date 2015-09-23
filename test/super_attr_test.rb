require 'test_helper'

describe "SuperAttr:Attr" do

	class Klass
		include SuperAttr::Attr

		super_attr :my_int, type: Integer, required: true
		super_attr :my_string, type: String, required: true
		super_attr :my_hash, type: Hash

		def initialize(args={})
			Klass.init_super_attrs(args, self)
		end

	end

	it "inits without any required attribute" do
		err = -> { Klass.new() }.must_raise StandardError
		err.message.must_equal 'Required attributes: my_int, my_string'
	end

	it "inits without required attribute :my_int" do
		err = -> { Klass.new(my_string: "foo") }.must_raise StandardError
		err.message.must_equal 'Required attributes: my_int'
	end

	it "sets the wrong type for attribute for int" do
		err = -> { Klass.new(my_int: "foo", my_string: "foo") }.must_raise StandardError
		err.message.must_equal 'The value for my_int is not a type Integer'
	end

	it "sets the wrong type for attribute for string" do
		err = -> { Klass.new(my_int: 20, my_string: 20) }.must_raise StandardError
		err.message.must_equal 'The value for my_string is not a type String'
	end

	it "sets the wrong type for attribute for string" do
		err = -> { Klass.new(my_int: 20, my_string: "foo", my_hash: "bazz") }.must_raise StandardError
		err.message.must_equal 'The value for my_hash is not a type Hash'
	end

	it "has the right types" do
		t = Klass.new(my_int: 20, my_string: "foo", my_hash: {name: "foo"})
		t.my_int.must_be_kind_of Integer
		t.my_string.must_be_kind_of String
		t.my_hash.must_be_kind_of Hash
	end

end
