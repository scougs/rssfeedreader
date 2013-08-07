
class Entry < ActiveRecord::Base

  belongs_to :feed
  # Besure to always destory, not delete to call this.
  has_many :entry_users, :dependent => :destroy

  has_many :users, through: :entry_users

   validates :url, :uniqueness => {:scope => :guid}

  attr_accessible :author, :categories, :content, :feed_id, :published, :summary, :title, :url, :guid

end
