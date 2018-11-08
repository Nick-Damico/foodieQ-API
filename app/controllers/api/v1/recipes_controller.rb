module Api::V1
  class RecipesController < ApplicationController
    before_action :authenticate_user
    before_action :set_recipe, only: [:new, :show, :update, :destroy]

    def index
      @recipes = Recipe.all

      render json: @recipes
    end

    private
    def recipe_params
    end

    def set_recipe
      @recipe = Recipe.find_by(id: params[:id])
    end
  end
end
