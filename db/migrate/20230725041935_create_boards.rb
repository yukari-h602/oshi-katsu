class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :title, null: false
      t.text :world, null: false
      t.text :charm, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
