class RemoveEtagFromFeeds < ActiveRecord::Migration
  def up
    remove_column :feeds, :etag
  end

  def down
    add_column :feeds, :etag, :text
  end
end
