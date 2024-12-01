class FixColumnName < ActiveRecord::Migration[8.0]
  def change
    rename_column :memos, :tag, :tagName
  end
end
