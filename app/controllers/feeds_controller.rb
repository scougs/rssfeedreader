class FeedsController < ApplicationController

before_filter :authenticate_user!
load_and_authorize_resource

  def index
    @userfeeds = FeedUser.where(user_id: current_user.id)

    @hash_userfeeds = FeedUser.hash_by_category(@userfeeds)
    #binding.pry
    # @feeds = Feed.all
  end

  # def index
  #   # url = params[:url]
  #   url = "http://www.boston.com/lifestyle/green/greenblog/2013/07/by_doug_struck_globe_correspon_3.html"
  #   url = "http://www.copyblogger.com"
  #   @feed = Feed.create_feed(url)
  #   if (@feed.id == nil)
  #       @feed = Feed.where(url: "http://www.copyblogger.com").first
  #       # @feed = Feed.where(url: "http://www.copyblogger.com").first
  #   end
  # end

  def show

    @feed = Feed.find(params[:id])
  end

  def new
    @feed = Feed.new
  end

  def edit
    @feed = Feed.find(params[:id])
  end

  def create
    url = params[:url]
    # Todo: Check if the xml url is available rather then homepage.
    @feed = Feed.where('url = :url OR feed_url = :url', url: url).first
    @user = User.find(current_user.id)
    #binding.pry
    if (@feed == nil)
      @feed = RSSReader.new.create_rss_feed(url)
       if(@feed != nil)
        @feed.save
      else
        return redirect_to feeds_path
      end
    end

    attributes = {
      feed_id: @feed.id,
      user_id: @user.id,
      category: (params[:category].capitalize)
    }

    FeedUser.create(attributes)
    # @feed = Feed.new(params[:feed])
    #binding.pry
    redirect_to feeds_path
  end

  def update
    @feed = Feed.find(params[:id])
    @feed.update_attributes(params[:feed])
    @feed.save
    redirect_to feeds_path
  end

  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy
    redirect_to feeds_path
  end
end