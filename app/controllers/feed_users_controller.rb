class FeedUsersController < ApplicationController

  def destroy
    FeedUser.find(params[:id]).destroy
    render nothing: true
  end
end
