class RenamePrivateToIsPrivateInFeedUser < ActiveRecord::Migration
  def up
    rename_column :feed_users, :private, :is_private
    change_column :feed_users, :is_private, :boolean, default: true, null: false
  end

  def down
    rename_column :feed_users, :is_private, :private
    change_column :feed_users, :private, :boolean
  end
end
