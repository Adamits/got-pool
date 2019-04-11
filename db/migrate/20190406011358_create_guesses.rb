class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.integer :user_id
      t.integer :question_id
      t.text :text
      t.boolean :correct, default: false
      t.boolean :extra_points, default: false
      t.boolean :negative_points, default: false
      t.timestamps
    end

    add_index :guesses, :user_id
    add_index :guesses, :question_id
  end
end
