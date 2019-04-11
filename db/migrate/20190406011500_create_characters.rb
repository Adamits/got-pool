class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.text :name
      t.text :status, default: :alive
      t.string :filename
      t.timestamps
    end
  end
end
