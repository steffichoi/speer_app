FactoryBot.define do
    factory :chat do
        message { Faker::Lorem.sentence }
        user_id { Faker::Number.number(10) }
        chatroom_id { Faker::Number.number(10) }
    end
end