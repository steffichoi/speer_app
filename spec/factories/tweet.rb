FactoryBot.define do
    factory :tweet do
        tweet { Faker::Lorem.sentence }
        created_by { Faker::Number.number(10) }
    end
end