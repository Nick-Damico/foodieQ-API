require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  before(:all) do
      @ingredient = build(:ingredient)
      @recipe     = build(:recipe)
      @ingredient.recipe = @recipe
  end

  it "can be created" do
    expect(@ingredient).to be_valid
  end

  it "is invalid with a blank name" do
    ingredient = build(:ingredient)
    ingredient.name = ''

    expect(ingredient).to_not be_valid
    expect(ingredient.errors[:name]).to include("can't be blank")
  end

  it 'is valid with name between 4 and 200 characters in length' do
    expect(@ingredient).to be_valid
  end

  it 'is invalid with name length less then 4' do
    ingredient = build(:ingredient)
    ingredient.name = '1oz'

    expect(ingredient).to_not be_valid
    expect(ingredient.errors[:name]).to include("is too short (minimum is 4 characters)")
  end

  it 'is invalid with name lenght greater then 200' do
    ingredient = build(:ingredient)
    ingredient.name = Faker::Lorem.sentence(201)

    expect(ingredient).to_not be_valid
    expect(ingredient.errors[:name]).to include("is too long (maximum is 200 characters)")
  end

  describe "belongs_to" do
    it 'belongs_to a Recipe' do
      recipe = build(:recipe)
      ingredient = build(:ingredient)
      recipe.ingredients << ingredient
      recipe.save

      expect(ingredient.recipe).to eq(recipe)
    end
  end
end
