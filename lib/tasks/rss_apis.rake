require 'open-uri'
require 'rss'
namespace :rss_apis do
  desc "Testing out parsing with feedzirra "
  task :feed => :environment do
    time = Time.now
    @feed=Feedzirra::Feed.fetch_and_parse("http://feeds.feedblitz.com/SethsBlog")
    puts "Time to fetch and parse with Feedzirra: #{Time.now-time}"
    binding.pry
    str_feed = open('http://feeds.feedblitz.com/SethsBlog').read
    @rss_url = nil
    str_feed.each_line do |l|
        puts l
        if (['application/atom','application/rss+'].include?('l'))
            binding.pry
            l_arr=l.split('"')
            l_arr.each do |string|
                if(string =~ /http:|https:/)
                    @rss_url = string
                    binding.pry
                end
            end
        end

        break if(@rss_url)

    end
    if(@rss_url)
        @feed=Feedzirra::Feed.fetch_and_parse(@rss_url)
    end

    binding.pry
  end

  task :rubyfeed => :environment do

        # url ="http://feeds.feedblitz.com/SethsBlog"
        time = Time.now
        url = "http://sethgodin.typepad.com/"
        doc = open(url)
        puts "Time to open a url is: #{Time.now-time}"
        if(doc.content_type == "text/html")
            url=get_rss_feed(doc)

        end
        open(url) do |rss|
            time = Time.now
            feed = RSS::Parser.parse(rss)
            puts "Time to parse a url feed is #{Time.now-time}"
            @type=feed.feed_type
            if (@type == "atom")
                attributes = {
                    title: feed.title.content,
                    feed_url: feed.link.href,
                    url: url,
                    last_modified: feed.updated.content,
                    etag: ""}
                c_feed = Feed.create(attributes)
                binding.pry if false
                # do atom protocols
            elsif(@type == "rss")
                # do rss protocols
                puts "Title: #{feed.channel.title}"
                feed.items.each do |item|
                    puts "Item: #{item.title}"
                end
            end
            binding.pry if false
        end
        puts Time.now-time
    end

    def get_rss_feed(file)
        str_feed = file.read

        rss_url = nil
        str_feed.each_line do |l|

            # Checks if the line includes either of these.
            if (l.include?('application/atom') || l.include?('application/rss'))
                l_arr=l.split('"')
                l_arr.each do |string|
                    if(string =~ /http:|https:/)
                        rss_url = string

                    end
                end
            end
            break if(rss_url)
        end

        return rss_url
    end


end