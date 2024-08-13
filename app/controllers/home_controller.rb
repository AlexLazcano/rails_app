class HomeController < ApplicationController
  def index
    @current_time = Time.now

    if @current_time.hour < 12
      @greeting = "Good Morning"
    elsif @current_time.hour < 17
      @greeting = "Good Afternoon"
    else
      @greeting = "Good Evening"
    end
  end
end
