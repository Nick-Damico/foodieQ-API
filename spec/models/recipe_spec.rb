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

    it 'is invalid without title' do
      recipe.title = ''
      expect(recipe).to_not be_valid
    end

    it 'title length cannot be greater than 100characters' do
      recipe.title = 'A' * 101;
      expect(recipe).to_not be_valid
    end
  end
end
