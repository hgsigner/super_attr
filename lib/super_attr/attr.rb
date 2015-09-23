module SuperAttr
	module Attr

		def self.included(base)
    	base.extend(AttrBase)
  	end

		module AttrBase

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
					if arg.is_a? opts[:type]
						instance_variable_set("@#{name}", arg)
					else
						raise StandardError.new("The value for #{name} is not a type #{opts[:type]}")
					end
				end

				@@required_attrs << name if opts.has_key?(:required) && opts[:required]

			end

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
				
				# Inits the args
				args_keys.each {|key| self.instance_method("#{key}=").bind(inst).call(args[key]) }
			end

		end

	end
end