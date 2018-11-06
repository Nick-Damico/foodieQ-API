FactoryBot.define do
  factory :ingredient do
    name { '1 Cup Flour' }

    factory :ingredient_two, parent: :ingredient do
      name { '16 oz Chicken'}
    end
    factory :ingredient_three, parent: :ingredient do
      name { '2 tsp. Salt'}
    end
  end
end
