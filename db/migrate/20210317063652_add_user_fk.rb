class AddUserFk < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :user_id, :integar
  end
end