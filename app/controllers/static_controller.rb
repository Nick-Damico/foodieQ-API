class StaticController < ApplicationController
  def welcome
    render html: "Welcome to FoodieQ Api"
  end
end
