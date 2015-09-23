module SuperAttr
	module Attr

		def self.included(base)
    	base.extend(AttrBase)
  	end

		module AttrBase

			# Initializes the array that will 
			# receive the required attributes,
			# as they are initialized.
			@@required_attrs = []

			# super_attr accpects the attr name and a hash
			# with type: and required:
			def super_attr(name, opts={})
				
				# Defines getter
				define_method("#{name}") do
					instance_variable_get("@#{name}")
				end

				# Defines setter
				define_method("#{name}=") do |arg|
					# If the arg is a kind of opts[:type]
					# it sets the value, otherwise, it will
					# raise a StandardError.
					if arg.is_a? opts[:type]
						instance_variable_set("@#{name}", arg)
					else
						raise StandardError.new("The value for #{name} is not a type #{opts[:type]}")
					end
				end

				# If the attribute is required, it will
				# push its name to the @@required_attrs array
				@@required_attrs << name if opts.has_key?(:required) && opts[:required]

			end

			# Initializes the arguments passed through the
			# initialize method in the Class where the
			# SuperAttr::Attr module was included.
			# It receives the initialization arguments
			# and an instance of the newly created class (self).
			def init_super_attrs(args={}, inst)
				args_keys = args.keys

				if @@required_attrs.any?
					# Checks if args_keys has all attr in the 
					# @@required_attrs. If args is empty, it will
					# raise an StandardError
					if args_keys.any?
						not_set_attrs = []
						@@required_attrs.each do |req|
							not_set_attrs << req unless args_keys.include?(req)
						end

						raise StandardError.new("Required attributes: #{not_set_attrs.join(", ")}") if not_set_attrs.any?
					else
						raise StandardError.new("Required attributes: #{@@required_attrs.join(", ")}")
					end

				end
				
				# Inits the arguments passed via the
				# initilize method.
				args_keys.each {|key| self.instance_method("#{key}=").bind(inst).call(args[key]) }
			end

		end

	end
end