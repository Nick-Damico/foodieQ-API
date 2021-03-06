class Api::V1::RecipesController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :set_recipe, only: %i[show update destroy]
  before_action :correct_user, only: %i[update destroy]
  before_action :recipe_owner, only: %i[update destroy]

  def index
    @pagy, @recipes = pagy(Recipe.all, items: 20)

    render json: @recipes, include: %w[ingredients steps], status: :ok
  end

  def show
    render json: @recipe, include: %w[ingredients steps], status: :ok
  end

  def create
    # Remember: Move logic of build a recipe to helper method
    recipe = build_recipe(params)

    if recipe.save
      render json: recipe, status: :created
    else
      render json: { errors: recipe.errors.full_messages }, status: :bad_request
    end
  end

  def update
    if @recipe.update_attributes(recipe_params)
      render json: @recipe, include: %w[ingredients steps], status: :ok
    else
      render json: { errors: @recipe.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    @recipe.destroy
    render json: {}, status: :no_content
  end

  private

  def recipe_params
    # Nested form submission was resulting in TypeError (no implicit conversion of Symbol into Integer):
    # Solution is to rewrite the params nested *_attributes to the correct format.
    params.require(:recipe).permit(:id, :title, :description, :image, :user_id, :published,
                                   ingredients_attributes: %i[id name], steps_attributes: %i[description])
  end

  def set_recipe
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe.nil?
      render json: { errors: [{
        status: '404',
        title: 'Record not found',
        detail: "Record not found with id: #{params[:id]}"
      }] }, status: :not_found
    end
  end

  def build_recipe(params)
    if params[:user_id].present?
      user = User.find_by(id: params[:user_id])
      recipe = user.recipes.build(recipe_params)
    else
      recipe = Recipe.new(recipe_params)
    end
  end

  # Confirms the current User is the Recipe owner before modify data
  def recipe_owner
    unless recipe_owner?(current_user, @recipe)
      render json: { errors: ["User not authorized to modify recipe that doesn't belong to them"] }, status: :bad_request
    end
  end

  def correct_user
    if params[:user_id].present?
      unless current_user?(User.find(params[:user_id]))
        render json: { errors: ["User not authorized to modify an account that doesn't belong to them"] }, status: :bad_request
      end
   end
  end
end
