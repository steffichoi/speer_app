require 'rails_helper'

RSpec.describe Chatroom, type: :model do
  
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }

  it { should have_many(:chats) }
  it { should have_many(:memberships) }
  it { should have_many(:users).through(:memberships) }

end

RSpec.describe Membership, type: :model do

  it { should validate_presence_of(:chatroom_id) }
  it { should validate_presence_of(:user_id) }

end

