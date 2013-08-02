class HomeController < ApplicationController

  def index
    url = "http://www.boston.com/lifestyle/green/greenblog/2013/07/by_doug_struck_globe_correspon_3.html"
    url = "http://www.copyblogger.com"
    @feed = Feed.create_feed(url)
    if (@feed.id == nil)
        @feed = Feed.where(url: "http://www.copyblogger.com").first

    end
  end

  def home
  end
end

