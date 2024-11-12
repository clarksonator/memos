class CreateSettings < ActiveRecord::Migration[7.2]
  def change
    create_table :settings do |t|
      t.string :title
      t.text :setting

      t.timestamps
    end
  end
end
