FactoryBot.define do
  factory :recipe do
    title {'Quick and Easy Pad Thai'}
    description {'this is Not a traditional pad Thai that is like the one served on the side of the road in Chang mai..nothing is I suppose! But what this is extremely yummy, and easy to make!'}
  end

  factory :recipe_2, parent: :recipe do
    title {'Apple Pie Moonshine'}
    description {'Pappys homemade Apple Pie Appalachian Moonshine'}
  end
end
