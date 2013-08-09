class AddFeedIdToEntryUsers < ActiveRecord::Migration
  def change
    add_column :entry_users, :feed_id, :integer
  end
end
