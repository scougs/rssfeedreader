class EntryUser < ActiveRecord::Base

  belongs_to :user
  belongs_to :entry
  validates :user_id, :uniqueness => {:scope => :entry_id}

  attr_accessible :archive, :entry_id, :favourite, :read, :user_id

end
