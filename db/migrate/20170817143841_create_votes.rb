class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :vote_value, { default: 0 }
      t.integer :user_id
      t.string :votable_type
      t.integer :votable_id

      t.timestamps
    end
  end
end
