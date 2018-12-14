class Api::V1::RecipesController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_recipe, only: [:show]

  def index
    recipes = Recipe.all
    render json: recipes, include: ['ingredients', 'steps'], status: :ok
  end

  def show
    render json: @recipe, include: ['ingredients', 'steps'], status: :ok
  end

  def create
    # Remember: Move logic of build a recipe to helper method
    if params[:user_id].present?
      user = User.find_by(id: params[:user_id])
      recipe = user.recipes.build(recipe_params)
    else
      recipe = Recipe.new(recipe_params)
    end

    if recipe.save
      render json: recipe, status: :created
    else
      render json: {errors: recipe.errors.full_messages}, status: :bad_request
    end
  end

  private
    def recipe_params
      # Nested form submission was resulting in TypeError (no implicit conversion of Symbol into Integer):
      # Solution is to rewrite the params nested *_attributes to the correct format.
      if params[:recipe][:ingredients_attributes].present?
        params[:recipe][:ingredients_attributes] = [{name: params[:recipe][:ingredients_attributes][:name]}]
      end
      params.require(:recipe).permit(:id, :title, :description, :user_id,
        ingredients_attributes: [:id, :name])
    end

    def set_recipe
      @recipe = Recipe.find_by(id: params[:id])
      if @recipe.nil?
        render json: {errors: [{
            status: '404',
            title: "Record not found",
            detail: "Record not found with id: #{params[:id]}"
          }]}, status: :not_found
      end
    end
end
