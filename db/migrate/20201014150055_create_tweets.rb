class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :tweet
      t.string :created_by

      t.timestamps
    end
  end
end
