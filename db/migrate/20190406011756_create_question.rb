class CreateQuestion < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :character_id
      t.text :text
      t.boolean :answered, default: false
      t.text :answer
      t.integer :points, default: 0
      t.timestamps
    end

    add_index :questions, :character_id
  end
end
