class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :user_name, :display_name
  end
end
