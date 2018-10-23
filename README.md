# HackerNews

This gem will allow you to read articles from hacker news.
This gem was built using the HN api.
The cli will allow you to test it's functionality and built in methods.

# The api_connector class

The api connector has a variety of article methods(#top_articles, #latest_articles etc.).
Each method will return an array with the requested article data in the hash format.
The above methods operate by using it's #get_page_date method and #genrate_article method.
The getter method will be called only if the articles weren't loaded before and it will save into it's respective variable.

The #get_page_date method takes in the page name and returns the article id's from that page.
```
def get_page_data(page = "newstories")
  # base URL
  base_url = "https://hacker-news.firebaseio.com/v0/"
  # build URL with requested page
  uri = URI(base_url + "#{page}.json" )
  # get page data
  response = Net::HTTP.get(uri)
  story_ids = JSON.parse(response)
end
```

The #genrate_article method takes in article id's and returns an array of article data as a hash.
```
def generate_article(page_data, count = 1)
 ...

 story_url = "https://hacker-news.firebaseio.com/v0/item/" + "#{page_data[i]}.json"
        story_uri = URI(story_url)
        #get page data
        story_response = Net::HTTP.get(story_uri)
        story = JSON.parse(story_response)
        # article hash builder
        new_story = {:title => story["title"] ||= nil,
                    :id => story["id"] ||= nil,
                    :type => story["type"] ||= nil,
                    :author => story["by"] ||= nil,
                    :time => story["time"] ||= nil,
                    :text => story["text"] ||= nil,
                    :url => story["url"] ||= nil,
                    :parent => story["parent"] ||= nil,
                    :descendants => story["descendants"] ||= nil,
                    :kids => story["kids"] ||= nil}
  ...
```
The #get_comments method works by passing in the child id's returned by #kids_by_id method from the article class.

# The article class

The article class get's intialized with article properties(title, text, id, children etc.).
Articles are generated with a #create_from_collection method. This method takes a hash of article data and returns an array with article objects.
The #create_from_collection method check for exsisting articles and only creates new articles.

The article class implements mutiple methods to sort, find, and search article objects. There is also an #all and #clear method.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hacker_news'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hacker_news


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/anihakutin/hacker_news. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the HackerNews project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/anihakutin/hacker_news/blob/master/CODE_OF_CONDUCT.md).
