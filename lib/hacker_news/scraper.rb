class HackerNews::SCRAPER

    require 'net/http'
    require 'json'
    require 'pry'

    # Takes count and returns hash with articles
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

    # Takes count and returns hash with articles
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
    # Takes page name and returns hash with article id's
    def get_page_data(page = "newstories")
      # New, Top and Best Stories
      # Up to 500 top and new stories are at /v0/topstories and /v0/newstories.
      # Best stories are at /v0/beststories.
      # -----------------
      # Ask, Show and Job Stories
      # Up to 200 of the latest Ask HN, Show HN, and Job stories are at
      # /v0/askstories, /v0/showstories, and /v0/jobstories.
      base_url = "https://hacker-news.firebaseio.com/v0/"
      uri = URI(base_url + "#{page}.json" )
      response = Net::HTTP.get(uri)
      story_ids = JSON.parse(response)
    end

    def generate_article(page_data)
      stories = [ ]
      # request each article via it's id
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
        i ++
      end
      # return array with articles as hash
      stories
    end
end
