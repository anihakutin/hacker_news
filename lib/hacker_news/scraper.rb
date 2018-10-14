class HackerNews::SCRAPER
    # Create method that returns hash with the amount of stories requested
    # Create method that returns the top 500 topstories, beststories or newstories
    # Create method that returns stories comments
    require 'net/http'
    require 'json'
    require 'pry'

    def get_stories(amount = 10)
      stories = {}
      url = "https://hacker-news.firebaseio.com/v0/newstories.json"
      uri = URI(url)
      response = Net::HTTP.get(uri)
      story_ids = JSON.parse(response)

      story_ids.each do |id|
        story_url = "https://hacker-news.firebaseio.com/v0/item/#{id}.json"
        story_uri = URI(story_url)
        story_response = Net::HTTP.get(story_uri)
        story = JSON.parse(story_response)
        binding.pry
        # stories = {:title => story.title,
        #           :type => ,
        #           :by => ,
        #           time: => ,
        #           text: => ,
        #           :url: => }
      end
    end

    def top_topstories

    end

    def best_stories

    end

    def news_stories

    end

    def story_comments(story)

    end
end
