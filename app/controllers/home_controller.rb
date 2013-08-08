class HomeController < ApplicationController

  def home
    if current_user
     @hash_userfeeds = current_user.feed_users_hashed_by_category
   end
  end
end

