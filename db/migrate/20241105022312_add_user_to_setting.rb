class AddUserToSetting < ActiveRecord::Migration[7.2]
  def change
    add_reference :settings, :user, null: false, foreign_key: true
  end
end
