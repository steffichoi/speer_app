class Chatroom < ApplicationRecord

    has_many :chats, dependent: :destroy
    
    has_many :memberships, foreign_key: :chatroom_id
    has_many :users, through: :memberships

    belongs_to :creator, foreign_key: :created_by, class_name: 'User'
    validates_presence_of :title, :created_by
    validates_uniqueness_of :title

end

class Membership < ApplicationRecord
    belongs_to :user
    belongs_to :chatroom

    validates_presence_of :chatroom_id, :user_id
end