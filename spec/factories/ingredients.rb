FactoryBot.define do
  factory :ingredient do
    name { '1 Cup Flour' }

    factory :chicken_ingredient, parent: :ingredient do
      name { '16 oz Chicken'}
    end
  end
end
