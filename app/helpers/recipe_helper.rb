module RecipeHelper
  def recipe_owner?(user,recipe)
    user.recipes.include?(recipe)
  end
end
