class FeedUsersController < ApplicationController

  def destroy
    FeedUser.find(params[:id]).destroy
    render nothing: true
  end

  def update
      feeduser=FeedUser.find(params[:id])
      feeduser.update_attribute("is_private", params["is_private"])
  end

  def update_category
    feeduser=FeedUser.find(params[:id])
    feeduser.update_attribute("category", params["new_category"])
    render nothing: true
  end

end
