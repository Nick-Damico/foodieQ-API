require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe "Recipe" do
    it "is valid with title, description" do
      recipe = Recipe.new(title: 'Quick and Easy Pad Thai',
                          description: 'this is Not a traditional pad Thai
                          that is like the one served on the side of the road in
                          Chang mai..nothing is I suppose! But what this is
                          extremely yummy, and easy to make!'
                        )
      expect(recipe).to be_valid        
    end
  end
end
