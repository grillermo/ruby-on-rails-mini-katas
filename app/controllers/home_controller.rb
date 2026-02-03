require 'slow/lib'

class HomeController < ApplicationController
  include Slow::Lib

  def root
    render plain: say_hi
  end
end
