require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:recipe) {Recipe.new(title: 'Quick and Easy Pad Thai',
                      description: 'this is Not a traditional pad Thai
                      that is like the one served on the side of the road in
                      Chang mai..nothing is I suppose! But what this is
                      extremely yummy, and easy to make!'
                    )}
  describe "Recipe" do
    it "is valid with title, description" do
      expect(recipe).to be_valid
    end

    describe 'title' do
      it 'is invalid without title' do
        recipe.title = ''
        expect(recipe).to_not be_valid
      end

      it 'is invalid with a title length greater then 100characters' do
        recipe.title = 'A' * 101
        expect(recipe).to_not be_valid
      end
    end

    describe 'description' do
      it 'is invalid without a description' do
        recipe.description = ''
        expect(recipe).to_not be_valid
      end

      it 'is invalid with a description greater then 1500 characters' do
        recipe.description = Faker::Lorem.paragraph_by_chars(1501)
        expect(recipe).to_not be_valid
      end

      it 'uses a #before_validation callback to captialize first letter' do
        recipe.description = "best cake yet"
        recipe.valid?
        expect(recipe.description).to eq('Best cake yet')
      end
    end

  end
end
