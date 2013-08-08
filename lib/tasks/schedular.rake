require 'open-uri'
require 'rss'
desc "Update Feeds"
task :update_feed => :environment do
    feeds=Feed.all
    first_time = Time.now
    count = 0
    feeds.each do |feed|
        time = Time.now
        open(feed.feed_url) do |rss|
            update(rss,feed)
            count += 1
            puts "#{Time.now-time}"
        end
    end
    puts "---- #{Time.now-first_time}"
end
     def update(rss,feed)
        feed_stream = RSS::Parser.parse(rss)
        type=feed_stream.feed_type
        if(type == "atom")
            feed.last_modified=feed_stream.updated.content
            binding.pry if DEBUG
            feed.save
            atom_update_delete_entries(feed_stream, feed)
        elsif(type =="rss")
            feed.last_modified =feed_stream.channel.lastBuildDate
            feed.save
            binding.pry if DEBUG
            rss_update_delete_entries(feed_stream, feed)
        end
    end
    def atom_update_delete_entries(feed_stream, feed_record)
        feed_stream.entries.each do |entry|
            # :author, :categories, :content, :feed_id, :published, :summary, :title, :url
            attributes = {
               title: entry.title.content,
                url:  entry.link.href,
                author: entry.author.name.content,
                content: entry.content.content,
                published: entry.updated.content,
                feed_id: feed_record.id,
                summary: clean_xml(entry.summary.content),
                guid: entry.id.content
            }
            binding.pry if DEBUG


            Entry.create(attributes)

        end
    end
    def rss_update_delete_entries(feed_stream, feed_record)
        feed_stream.channel.items.each do |item|
             attributes = {
               title: item.title,
                url:  item.link,
                author: item.author,
                summary: item.description,
                content: clean_xml(item.content_encoded),
                published: item.pubDate,
                feed_id: feed_record.id,
                # categories: item.categories,
                guid: item.guid.content
            }
            binding.pry if DEBUG
            Entry.create(attributes)

        end
    end
    def extract_rss_feed(file)
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
    #  or just use raw HTML
    # <%= raw 'insert the xmlz stuff' %>
    def clean_xml xml
        return HTMLEntities.new.decode(xml)
    end
    def atom_create_entries(feed_stream, feed_record)
        feed_stream.entries.each do |entry|
            # :author, :categories, :content, :feed_id, :published, :summary, :title, :url
            attributes = {
               title: entry.title.content,
                url:  entry.link.href,
                author: entry.author.name.content,
                content: entry.content.content,
                published: entry.updated.content,
                feed_id: feed_record.id,
                summary: clean_xml(entry.summary.content),
                guid: entry.id.content
            }
            binding.pry if DEBUG
            Entry.create(attributes)

        end
    end


 # <item>
 #  <title>Example entry</title>
 #  <description>Here is some text containing an interesting description.</description>
 #  <link>http://www.wikipedia.org/</link>
 #  <guid>unique string per item</guid>
 #  <pubDate>Mon, 06 Sep 2009 16:20:00 +0000 </pubDate>
 # </item>

 # TODO: Add categories, perhaps a relation database
    def rss_create_entries(feed_stream, feed_record)

        feed_stream.channel.items.each do |item|
             attributes = {
               title: item.title,
                url:  item.link,
                author: item.author,
                summary: item.description,
                content: clean_xml(item.content_encoded),
                published: item.pubDate,
                feed_id: feed_record.id,
                # categories: item.categories,
                guid: item.guid.content
            }
            Entry.create(attributes)

        end
    end


  desc "Testing out parsing with feedzirra "
  task :feedz => :environment do
    time = Time.now
    @feed=Feedzirra::Feed.fetch_and_parse("http://feeds.feedblitz.com/SethsBlog")
    puts "Time to fetch and parse with Feedzirra: #{Time.now-time}"

    str_feed = open('http://feeds.feedblitz.com/SethsBlog').read
    @rss_url = nil
    str_feed.each_line do |l|
        puts l
        if (['application/atom','application/rss+'].include?('l'))
            l_arr=l.split('"')
            l_arr.each do |string|
                if(string =~ /http:|https:/)
                    @rss_url = string
                end
            end
        end

        break if(@rss_url)

    end
    if(@rss_url)
        @feed=Feedzirra::Feed.fetch_and_parse(@rss_url)
    end


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
