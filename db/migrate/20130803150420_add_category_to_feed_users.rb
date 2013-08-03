class AddCategoryToFeedUsers < ActiveRecord::Migration
  def change
    add_column :feed_users, :category, :string
  end
end
