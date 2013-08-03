class RemoveTagFromFeedUsers < ActiveRecord::Migration
  def up
    remove_column :feed_users, :tag
  end

  def down
    add_column :feed_users, :tag, :string
  end
end
