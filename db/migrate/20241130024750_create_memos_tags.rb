class CreateMemosTags < ActiveRecord::Migration[8.0]
  def change
    create_table :memos_tags do |t|
      t.integer :memo_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
