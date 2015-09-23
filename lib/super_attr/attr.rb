module SuperAttr
	module Attr

		def self.included(base)
    	base.extend(AttrBase)
  	end

		module AttrBase
			def super_attr(name, opts={})
				
				define_method("#{name}") do
					instance_variable_get("@#{name}")
				end

				define_method("#{name}=") do |arg|
					if arg.is_a? opts[:type]
						instance_variable_set("@#{name}", arg)
					else
						raise StandardError.new("The value for #{name} is not a type #{opts[:type]}")
					end
				end
				
			end
		end

	end
end