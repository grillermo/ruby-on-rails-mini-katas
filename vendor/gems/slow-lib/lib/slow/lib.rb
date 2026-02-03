# frozen_string_literal: true

require_relative "lib/version"

module Slow
  module Lib
    puts 'loading slow lib...'
    sleep(30)
    puts 'finished loading it'

    def say_hi
      'hi'
    end
  end
end
