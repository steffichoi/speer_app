class Chat < ApplicationRecord
    belongs_to :user
    belongs_to :chatroom
    validates_presence_of :message, :user_id, :chatroom_id
end
  