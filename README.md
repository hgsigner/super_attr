# SuperAttr

SuperAttr is an implementation of attr_accessor on steroires. It sets the name of the attribute, as well as its type and if it is required or not.

## Usage

```ruby
require 'super_attr'

class Klass
	include SuperAttr::Attr

	super_attr :my_int, type: Integer, required: true
	super_attr :my_string, type: String, required: true
	super_attr :my_hash, type: Hash

	def initialize(args={})
		Klass.init_super_attrs(args, self)
	end
end

k = Klass.new(my_int: 20, my_string: "foo", my_hash: {name: "foo"})
k.my_int    # returns 20, assuring that the result is an Integer
k.my_string # returns foo, assuring that the result is a String
k.my_hash   # returns {name: "foo"}, assuring that the result is a Hash
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hgsigner/super_attr. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

