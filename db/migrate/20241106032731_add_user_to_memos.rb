class AddUserToMemos < ActiveRecord::Migration[7.2]
  def change
    add_reference :memos, :user, null: false, foreign_key: true
  end
end
