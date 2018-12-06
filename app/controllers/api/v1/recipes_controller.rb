class Api::V1::RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: [:index, :show]

  def index
    @recipes = Recipe.all
    render json: @recipes
  end

  def show
    if @recipe
      render json: @recipe, status: :sucessful
    end
  end

  private
  def recipe_params
  end

  def set_recipe
    @recipe = Recipe.find_by(id: params[:id])
    end
end
