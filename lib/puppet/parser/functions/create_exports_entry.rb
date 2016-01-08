module Puppet::Parser::Functions
    newfunction(:create_exports_entry, :type => :rvalue) do |args|
        if args.size != 3
            raise(Puppet::ParseError, "create_exports_entry(): Takes exactly two arguments, #{arguments.size} given.")
        end

        directory = args[0]
        clients = args[1]
        options = args[2]

        if not directory.is_a?(String)
            raise(TypeError, "create_exports_entry(): The first argument must be a string, but a #{directory.class} was given.")
        end

        if not clients.is_a?(Array)
            raise(TypeError, "create_exports_entry(): The second argument must be an array, but a #{clients.class} was given.")
        end

        if not options.is_a?(String)
            raise(TypeError, "create_exports_entry(): The third argument must be a string, but a #{options.class} was given.")
        end

        exports_entry = "#{directory} "

        clients.each do |client|
            exports_entry += "#{client}(#{options}) "
        end

        exports_entry += "\n"
        return exports_entry
    end
end
