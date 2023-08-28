class CreateBoardTags < ActiveRecord::Migration[7.0]
  def change
    create_table :board_tags do |t|
      t.references :board, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    add_index :board_tags, [:board_id, :tag_id], unique: true
  end
end
