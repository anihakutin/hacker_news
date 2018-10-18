class HackerNews::CLI

  def call
    @api_connector = HackerNews::API_CONNECTOR.new

    menu
    good_bye
  end

  def display_news(articles)
    puts "\n ----You ask, you get...---- \n\n"
    # Print article objects
    articles.each do |x|
    if x.type == "comment"
        puts "Comment by #{x.author}"
      else
        puts "#{x.title} by #{x.author}"
      end
      puts "Link #{x.url}" unless x.url == nil
      puts "#{x.descendants} comments, Article ID: #{x.id}" unless x.descendants == nil
      puts "#{x.text}" unless x.text == nil
      puts "\n"
    end

    puts "------------------------ \n"
  end

  def menu
    input = nil

    puts "\n"
    puts "Welcome to hacker news!(~~beta~~)"
    puts "Enter the number of the menu option you'd like to see, or type exit to exit:"
    puts <<~STRING
          1. Show ten newest posts
          2. Show ten top posts
          3. Show ten best posts
          4. Show ten 'show HN' posts
          5. Get article comments by id
          6. Search for article(in top 10)
          7. Sort articles by Title/Author
    STRING

    input = gets.strip.downcase

    if input != "exit"
      case input
      when "1"
        # Clear all articles
        # Get articles
        # Create article objects
        # Display articles to user
        HackerNews::ARTICLE.clear

        stories = @api_connector.latest_articles(10)
        articles = HackerNews::ARTICLE.create_from_collection(stories)

        display_news(articles)
        menu

      when "2"
        HackerNews::ARTICLE.clear

        stories = @api_connector.top_articles(10)
        articles = HackerNews::ARTICLE.create_from_collection(stories)

        display_news(articles)
        menu

      when "3"
        HackerNews::ARTICLE.clear

        stories = @api_connector.best_articles(10)
        articles = HackerNews::ARTICLE.create_from_collection(stories)

        display_news(articles)
        menu

      when "4"
        HackerNews::ARTICLE.clear

        stories = @api_connector.show_articles(10)
        articles = HackerNews::ARTICLE.create_from_collection(stories)

        display_news(articles)
        menu

      when "5"
        puts "Please enter article ID:"

        input = gets.strip

        kids = HackerNews::ARTICLE.kids_by_id(input)

        if kids.first == nil
          puts "Invalid article ID"
        else
          stories = @api_connector.get_comments(kids.first, kids.last)

          articles = HackerNews::ARTICLE.create_from_collection(stories)
          display_news(articles)
        end

        menu

      when "6"
        puts <<~STRING
              Please select what section you'd like to search
                1. Top Posts
                2. Newest
                3. Show HN
                4. Ask
                5. jobs
              STRING

        input = gets.strip.downcase

        case input
        when "1"
          puts "Please enter your keyword"
          input = gets.strip.downcase
          # Clear all articles
          # Get articles
          # Create article objects
          # Find article requested by user
          HackerNews::ARTICLE.clear

          articles = @api_connector.top_articles(100)
          HackerNews::ARTICLE.create_from_collection(articles)

          articles = HackerNews::ARTICLE.find_by_keyword("story", input)

          if !articles.empty?
             display_news(articles)
          else
             puts "No matching keywords found \n"
             menu
          end

        when "2"
          puts "Please enter your keyword"
          input = gets.strip.downcase

          HackerNews::ARTICLE.clear

          articles = @api_connector.latest_articles(100)
          HackerNews::ARTICLE.create_from_collection(articles)

          articles = HackerNews::ARTICLE.find_by_keyword("story", input)

          if !articles.empty?
             display_news(articles)
           else
             puts "No matching keywords found \n"
             menu
          end

        when "3"
          puts "Please enter your keyword"

          input = gets.strip.downcase

          HackerNews::ARTICLE.clear

          articles = @api_connector.show_articles(100)
          HackerNews::ARTICLE.create_from_collection(articles)

          articles = HackerNews::ARTICLE.find_by_keyword("story", input)

          if !articles.empty?
             display_news(articles)
           else
             puts "No matching keywords found \n"
             menu
          end

        when "4"
          puts "Please enter your keyword"

          input = gets.strip.downcase
          HackerNews::ARTICLE.clear

          articles = @api_connector.ask_articles(100)
          HackerNews::ARTICLE.create_from_collection(articles)

          articles = HackerNews::ARTICLE.find_by_keyword("story", input)

          if !articles.empty?
             display_news(articles)
           else
             puts "No matching keywords found \n"
             menu
          end

        when "5"
           puts "Please enter your keyword"
           input = gets.strip.downcase

           HackerNews::ARTICLE.clear

           articles = @api_connector.job_articles(100)
           HackerNews::ARTICLE.create_from_collection(articles)

           articles = HackerNews::ARTICLE.find_by_keyword("job", input)

           if !articles.empty?
              display_news(articles)
           else
              puts "No matching keywords found \n"
              menu
           end
          else
            puts "Please enter a valid menu selection"
            menu
          end

          menu

      when "7"
        HackerNews::ARTICLE.clear

        articles = @api_connector.top_articles(50)
        HackerNews::ARTICLE.create_from_collection(articles)

        puts "Please enter how you would like to sort the News articles(by 1. Title, 2. Author)"

        input = gets.strip.downcase

        case input
          when "1"
          articles = HackerNews::ARTICLE.sort_by_name

          display_news(articles)

          when "2"
            articles = HackerNews::ARTICLE.sort_by_author

            display_news(articles)
          else
            puts "Please enter a valid menu selection"
            menu
          end

          menu

        else
          puts "Please enter a valid menu selection"
          menu
        end
      end
    end

  def good_bye
    puts "Thanks for reading Hacker News!"
  end
end
