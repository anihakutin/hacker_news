class HackerNews::SCRAPER

    require 'net/http'
    require 'json'
    require 'pry'

    # Takes count and returns hash with articles
    # https://news.ycombinator.com/newest
    def latest_articles(count = 10)
      # set URL and get article id's
      stories = get_page_data("newstories")
      # generate articles and return article array
      generate_article(stories, count)
    end

    # Takes count and returns hash with articles
    # https://news.ycombinator.com/news
    def top_articles(count = 10)
      # set URL and get article id's
      stories = get_page_data("topstories")
      # generate articles and return article array
      generate_article(stories, count)
    end

    def show_articles(count = 10)
      # set URL and get article id's
      stories = get_page_data("showstories")
      # generate articles and return article array
      generate_article(stories, count)
    end

    def ask_articles(count = 10)
      # set URL and get article id's
      stories = get_page_data("askstories")
      # generate articles and return article array
      generate_article(stories, count)
    end

    def jobs

    end
    # Takes page name and returns hash with article id's
    def get_page_data(page = "newstories")
      # base URL
      base_url = "https://hacker-news.firebaseio.com/v0/"
      # build URL with requested page
      uri = URI(base_url + "#{page}.json" )
      # get page data
      response = Net::HTTP.get(uri)
      # parse data
      story_ids = JSON.parse(response)
    end

    # generate article with page id's, return "count" articles
    def generate_article(page_data, count = 10)
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
                      # parse data
                      story = JSON.parse(story_response)
                        # article hash builder
                          new_story = {:title => story["title"],
                                      :type => story["type"],
                                      :author => story["by"],
                                      :time => story["time"],
                                      :text => story["story"],
                                      :url => story["url"]}
                      # build article array
                stories << new_story
              i += 1
            end
      # return array with articles as hash
      stories
    end
end
