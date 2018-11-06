require 'rails_helper'

RSpec.describe Step, type: :model do

  before do
    @recipe = build(:recipe)
    @step = build(:step)
    @recipe.steps << @step
  end

  it 'can be created' do
    expect(@step).to be_valid
  end

  describe 'description' do
    it 'is invalid with a blank description' do
      invalid_step = build(:invalid_step)

      expect(invalid_step).to_not be_valid
      expect(invalid_step.errors[:description]).to include("can't be blank")
    end

    it "can't have a description longer then 500 characters" do
      invalid_step = build(:invalid_step_length)

      expect(invalid_step).to_not be_valid
      expect(invalid_step.errors[:description]).to include("is too long (maximum is 500 characters)")
    end
  end

  describe 'belongs to Recipe' do
    it 'belongs to a Recipe' do
      recipe = build(:recipe)
      step = recipe.steps.build(description: 'Add 8 oz of Chicken to pot')
      recipe.save

      expect(step.recipe).to eq(recipe)
    end
  end
end
