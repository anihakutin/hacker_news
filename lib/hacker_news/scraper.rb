class HackerNews::SCRAPER

    require 'net/http'
    require 'json'
    require 'pry'

    # Takes count and returns hash
    # https://news.ycombinator.com/newest
    def latest_articles(count = 10)
      # return variable
      stories = [ ]
      # Print status
      print "Loading articles."
      # Set url
      url = "https://hacker-news.firebaseio.com/v0/newstories.json"
      uri = URI(url)
      print "."
      # Get data
      response = Net::HTTP.get(uri)
      print "."
      # parse data
      story_ids = JSON.parse(response)
      print "."
      # create hash using article id's
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

    # Takes count and returns hash
    # https://news.ycombinator.com/news
    def top_articles(count = 200)
      # return variable
      stories = [ ]
      # print status
      print "Loading articles."
      # set url
      url = "https://hacker-news.firebaseio.com/v0/topstories.json"
      uri = URI(url)
      print "."
      # get data
      response = Net::HTTP.get(uri)
      print "."
      # parse data
      story_ids = JSON.parse(response)
      print "."
      # create hash using article id's
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
