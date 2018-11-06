require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  before(:all) do
      @ingredient = build(:ingredient)
  end

  it "can be created" do
    expect(@ingredient).to be_valid
  end

  it "is invalid with a blank name" do
    ingredient = build(:ingredient)
    ingredient.name = ''
    expect(ingredient).to_not be_valid
  end

  it 'is valid with name between 8 and 200 characters in length' do
    expect(@ingredient).to be_valid
  end

  it 'is invalid with name length less then 8' do
    ingredient = build(:ingredient)
    ingredient.name = 'cup tea'
    expect(ingredient).to_not be_valid
  end

  it 'is invalid with name lenght greater then 200' do
    ingredient = build(:ingredient)
    ingredient.name = Faker::Lorem.sentence(201)
    expect(ingredient).to_not be_valid
  end
end
