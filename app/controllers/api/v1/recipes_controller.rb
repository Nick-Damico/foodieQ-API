class Api::V1::RecipesController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_recipe, only: [:show, :update, :destroy]
  before_action :correct_user, only: [:update, :destroy]

  def index
    recipes = Recipe.all
    render json: recipes, include: ['ingredients', 'steps'], status: :ok
  end

  def show
    render json: @recipe, include: ['ingredients', 'steps'], status: :ok
  end

  def create
    # Remember: Move logic of build a recipe to helper method
    recipe = build_recipe(params)

    if recipe.save
      render json: recipe, status: :created
    else
      render json: {errors: recipe.errors.full_messages}, status: :bad_request
    end
  end

  def update
    if @recipe.update_attributes(recipe_params)
      render json: @recipe, include: ['ingredients', 'steps'], status: :ok
    else
      render json: {errors: @recipe.errors.full_messages}, status: :bad_request
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

    def build_recipe(params)
      if params[:user_id].present?
        user = User.find_by(id: params[:user_id])
        recipe = user.recipes.build(recipe_params)
      else
        recipe = Recipe.new(recipe_params)
      end
    end

    # Confirms the correct user.
   def correct_user
     if params[:user_id].present?
       @user = User.find_by(id: params[:user_id])
       
       if @user != current_user && !@user.recipes.include?(@recipe)
         render json: {errors: ["User not authorized to modify recipe that doesn't belong to them"]}, status: :bad_request
       end
     end
   end
end
