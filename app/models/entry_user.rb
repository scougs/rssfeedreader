class EntryUser < ActiveRecord::Base

  belongs_to :user
  belongs_to :entry

  validates_presence_of :user_id
  validates_presence_of :entry_id
  validates_presence_of :feed_id

  validates :user_id, :uniqueness => {:scope => :entry_id}

  attr_accessible :archive, :entry_id, :favourite, :read, :user_id, :feed_id

end
