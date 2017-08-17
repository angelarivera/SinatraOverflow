class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :description, null: false
      t.integer :question_id
      t.integer :answerer_id

      t.timestamps
    end
  end
end
