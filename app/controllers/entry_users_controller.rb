class EntryUsersController < ApplicationController
  def create
    entryuser=EntryUser.where(user_id: current_user.id, entry_id: params[:entry_id], feed_id: params[:feed_id]).first_or_initialize
    if(params[:read] )
      entryuser.read = params[:read]
    end

    if(params[:archive])
      entryuser.archive = params[:archive]
    end

    if(params[:favourite])
      entryuser.favourite = params[:favourite]
    end

    entryuser.save
    render nothing: true
  end
end