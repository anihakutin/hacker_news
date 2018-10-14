class HackerNews::SCRAPER
    # Create method that returns hash with the amount of stories requested
    # Create method that returns the top 500 topstories, beststories or newstories
    # Create method that returns stories comments
    require 'net/http'
    require 'json'
    require 'pry'

    def latest_articles(count = 10)
      print "Loading articles."
      stories = [ ]
      url = "https://hacker-news.firebaseio.com/v0/newstories.json"
      uri = URI(url)
      print "."
      response = Net::HTTP.get(uri)
      print "."
      story_ids = JSON.parse(response)
      print "."
      i = 0
      while i < count
        print "."
        story_url = "https://hacker-news.firebaseio.com/v0/item/#{story_ids[i]}.json"
        story_uri = URI(story_url)
        story_response = Net::HTTP.get(story_uri)
        story = JSON.parse(story_response)

        new_story = {:title => story["title"],
                  :type => story["type"],
                  :author => story["by"],
                  :time => story["time"],
                  :text => story["story"],
                  :url => story["url"]}
        stories << new_story
        i += 1
      end
      print "\n"
      stories
    end

    def top_articles(count = 10)
      print "Loading articles."
      stories = [ ]
      url = "https://hacker-news.firebaseio.com/v0/topstories.json"
      uri = URI(url)
      print "."
      response = Net::HTTP.get(uri)
      print "."
      story_ids = JSON.parse(response)
      print "."
      i = 0
      while i < count
        print "."
        story_url = "https://hacker-news.firebaseio.com/v0/item/#{story_ids[i]}.json"
        story_uri = URI(story_url)
        story_response = Net::HTTP.get(story_uri)
        story = JSON.parse(story_response)

        new_story = {:title => story["title"],
                  :type => story["type"],
                  :author => story["by"],
                  :time => story["time"],
                  :text => story["story"],
                  :url => story["url"]}
        stories << new_story
        i += 1
      end
      print "\n"
      stories
    end

    def show_articles

    end

    def ask_articles

    end

    def jobs

    end
end
