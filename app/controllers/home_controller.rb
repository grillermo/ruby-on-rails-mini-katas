class HomeController < ApplicationController
  def root
    require 'slow/lib'
    self.extend(Slow::Lib)

    render plain: say_hi
  end

  def omg
    render plain: "omg"
  end
end
