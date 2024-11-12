class CreateMemos < ActiveRecord::Migration[7.2]
  def change
    create_table :memos do |t|
      t.string :title
      t.text :body
      t.string :tag

      t.timestamps
    end
  end
end
