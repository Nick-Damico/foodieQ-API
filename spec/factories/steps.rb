FactoryBot.define do
  factory :step do
    description { "Add 8 oz of Chicken to broth." }
    recipe_id { 1 }

    factory :invalid_step, parent: :step do
      description { nil }
      recipe_id { 1 }
    end

    factory :invalid_step_length, parent: :step do
      description { Faker::Lorem.sentence(501)}
      recipe_id { 1 }
    end
  end
end
