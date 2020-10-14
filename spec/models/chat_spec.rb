require 'rails_helper'

RSpec.describe Chat, type: :model do

  it { should belong_to(:user) }
  it { should belong_to(:chatroom) }
  it { should validate_presence_of(:message)}
  it { should validate_presence_of(:user_id)}
  it { should validate_presence_of(:chatroom_id)}

end
