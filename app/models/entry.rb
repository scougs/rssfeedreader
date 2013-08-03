
class Entry < ActiveRecord::Base

  belongs_to :feed
  has_many :users, through: :entry_user

   validates :url, :uniqueness => {:scope => :guid}

  attr_accessible :author, :categories, :content, :feed_id, :published, :summary, :title, :url, :guid

end
