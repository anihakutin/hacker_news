class HackerNews::SCRAPER

  def initialize
    @loaded_articles = { }
  end

    # Takes count and returns hash with articles
    # set URL and get article id's
    # generate articles and return article array
    def latest_articles(count = 10)
      stories = get_page_data("newstories")
      @loaded_articles[:latest_stories] ||= generate_article(stories, count)
    end

    def top_articles(count = 10)
      stories = get_page_data("topstories")
      @loaded_articles[:top_stories] ||= generate_article(stories, count)
    end

    def best_articles(count = 10)
      stories = get_page_data("beststories")
      @loaded_articles[:best_stories] ||= generate_article(stories, count)
    end

    def show_articles(count = 10)
      stories = get_page_data("showstories")
      @loaded_articles[:show_stories] ||= generate_article(stories, count)
    end

    def ask_articles(count = 10)
      stories = get_page_data("askstories")
      @loaded_articles[:ask_stories] ||= generate_article(stories, count)
    end

    def job_articles(count = 20)
      stories = get_page_data("jobstories")
      @loaded_articles[:job_stories] ||= generate_article(stories, count)
    end

    def get_comment

    end

    # Takes page name and returns hash with article id's
    def get_page_data(page = "newstories")
      # base URL
      base_url = "https://hacker-news.firebaseio.com/v0/"
      # build URL with requested page
      uri = URI(base_url + "#{page}.json" )
      # get page data
      response = Net::HTTP.get(uri)
      story_ids = JSON.parse(response)
    end

    # generate article with page id's, return "count" articles
    def generate_article(page_data, count = 1)
      # print current status to user
      print "Loading articles."
      # return variable
      stories = [ ]
      # request each article via it's post id
      i = 0
      while i < count
        print "."
        # set URL
        story_url = "https://hacker-news.firebaseio.com/v0/item/" + "#{page_data[i]}.json"
        story_uri = URI(story_url)
        #get page data
        story_response = Net::HTTP.get(story_uri)
        story = JSON.parse(story_response)
        # article hash builder
        new_story = {:title => story["title"],
                    :id => story["id"],
                    :type => story["type"],
                    :author => story["by"],
                    :time => story["time"],
                    :text => story["story"],
                    :url => story["url"],
                    :parent => story["parent"],
                    :descendants => story["descendants"],
                    :kids => story["kids"]}
        stories << new_story
        i += 1
      end
      # return array with articles as hash
      print "\n"
      stories
    end
end
