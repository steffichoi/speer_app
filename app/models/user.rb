class User < ApplicationRecord

    # encrypt password
    has_secure_password

    # Model associations
    has_many :chats
    
    has_many :chatrooms, foreign_key: :created_by
    has_many :memberships, foreign_key: :user_id
    has_many :chatrooms, through: :memberships
    
    # has_many :chatrooms, through: :chats

    # Validations
    validates_presence_of :name, :username, :email, :password_digest
    validates_uniqueness_of :username
    
end
