require 'rails_helper'

RSpec.describe Ingredient, type: :model do

  it "can be created" do
    ingredient = Ingredient.create!(name: '1 cup flour')
    expect(ingredient).to be_valid
  end
end
