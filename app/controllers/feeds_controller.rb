class FeedsController < ApplicationController

before_filter :authenticate_user!
load_and_authorize_resource

  def index
    @hash_userfeeds = current_user.feed_users_hashed_by_category
    respond_to do |format|
      format.html 
      format.js
    end
  end

  def show
    @feed = Feed.find(params[:id])
    @entryusers=current_user.entry_users.where('read is NULL AND feed_id = ? OR read = false AND feed_id = ? ', @feed.id, @feed.id).page(params[:page]).per(15)
  end

  def new
    @feed = Feed.new
  end

  def edit
    @feed = Feed.find(params[:id])
  end

  def create
    if(params[:url].start_with?('http://') || params[:url].start_with?('https://') )
      Feed.thread_create(params[:url],params[:category],current_user.id)
    else
      flash[:error]="Invalid Url."
    end
    redirect_to feeds_path
  end

  def update
    @feed = Feed.find(params[:id])
    @feed.update_attributes(params[:feed])
    redirect_to feeds_path
  end

  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy
    redirect_to feeds_path
  end
end