require "generators/minitest"

module Minitest
  module Generators
    class Base
      private
      def template(source, destination = nil, *args, &block)
        destination ||= source
        destination = destination.to_s.gsub(/^test\//, "spec/")
        super(source, destination, *args, &block)
      end
    end
  end
end
