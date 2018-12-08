class Api::V1::RecipesController < ApplicationController
  # before_action :authenticate_user!
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

  def create
    recipe = Recipe.new(recipe_params)
    if recipe.save
      render json: recipe, status: :created
    else
      render json: {errors: recipe.errors.full_messages}, status: :bad_request
    end
  end

  private
    def recipe_params
      params.require(:recipe).permit(:title, :description)
    end

    def set_recipe
      @recipe = Recipe.find_by(id: params[:id])
    end
end
