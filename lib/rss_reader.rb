require 'open-uri'
require 'rss'


class RSSReader
    def try_open(url)
        begin
            doc=open(url)
        rescue
            puts "Error with connecting to url."
            return nil
        end
        return doc
    end
    # Since the execution time is too slow, this will be run in a thread.
    # Later on to update a page we might need javascript.
     def create_rss_feed(url)
        # url ="http://feeds.feedblitz.com/SethsBlog"
        time = Time.now
        # url = "http://sethgodin.typepad.com/"
        url = url
        # home_url =  "http://sethgodin.typepad.com/"
        doc = try_open(url)

        return nil if doc.nil?
        binding.pry if DEBUG
        #binding.pry

        if(doc.content_type == "text/html")
            url=extract_rss_feed(doc)
            puts Time.now-time
        end


        binding.pry if DEBUG
        #binding.pry
        return nil if url.nil?
        # TODO: check if rss feed is valid Url - error handling
        open(url) do |rss|
            time = Time.now
            feed_stream = RSS::Parser.parse(rss)
            puts "Time to parse a url feed is #{Time.now-time}"
            @type=feed_stream.feed_type
            if (@type == "atom")

                @feed=Feed.where(title: feed_stream.title.content).first
                binding.pry if DEBUG
                return @feed if(@feed)

                attributes = {
                    title: feed_stream.title.content,
                    feed_url: feed_stream.link.href,
                    url: url,
                    last_modified: feed_stream.updated.content
                }
                @feed = Feed.create(attributes)

                # call method to get entries or feed
                atom_create_entries(feed_stream, @feed)
                # do atom protocols
            elsif(@type == "rss")


                @feed=Feed.where(title: feed_stream.channel.title).first
                binding.pry if DEBUG
                return @feed if(@feed)

                # do rss protocols
                attributes = {
                    title: feed_stream.channel.title,
                    feed_url: url,
                    url: feed_stream.generator.uri,
                    # perhaps fix this to pubDate
                    last_modified: feed_stream.channel.lastBuildDate
                }

                    @feed = Feed.create(attributes)
                rss_create_entries(feed_stream, @feed)
            end
            #binding.pry if false
        end
        puts Time.now-time
        return @feed
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
        # binding.pry
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
end