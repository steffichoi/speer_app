class CreateChatrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :chatrooms do |t|
      t.string :title
      t.string :created_by

      t.timestamps
    end

    create_table :memberships do |t|
      t.string :chatroom_id
      t.string :user_id
    end
  end
end
