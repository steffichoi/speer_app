FactoryBot.define do
    factory :chatroom do
  
      title { Faker::Name.name }
      created_by { Faker::Number.number(10) }
      # created_by { Faker::Number.number(10) }
  
      # # trait :with_a_user_and_memberships do
      #   after(:build) do |chatroom|
      #     chatroom.memberships << FactoryBot.create(:membership, chatroom_id: chatroom.id, user_id: chatroom.created_by)
      #   end
      # # end
    end
  end
  
  FactoryBot.define do
    factory :membership do
      chatroom_id { Faker::Number.number(10) }
      user_id { Faker::Number.number(10) }
    end
  end
  