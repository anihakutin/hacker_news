class HackerNews::CLI

  def call
    @scraper = HackerNews::SCRAPER.new

    menu
    good_bye
  end

  def display_news(articles)
    puts "\n ----You ask, you get...---- \n\n"
    # Print article objects
    articles.each do |x|
      puts "#{x.title} by #{x.author}"
      puts "Link #{x.url}"
      puts "#{x.descendants} comments, Article ID: #{x.id}"
      puts "#{x.text}"
    end

    puts "------------------------ \n"

  end

  def menu
    input = nil

    puts "\n"
    puts "Welcome to hacker news!"
    puts "Enter the number of the menu option you'd like to see, or type exit to exit:"
    puts <<~STRING
          1. Show ten newest posts
          2. Show ten top posts
          3. Show ten best posts
          4. Show ten 'show HN' posts
          5. Get article comments by id
          6. Search for article(in top 200)
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

      stories = @scraper.latest_articles(10)
      articles = HackerNews::ARTICLE.create_from_collection(stories)

      display_news(articles)
    when "2"
      HackerNews::ARTICLE.clear

      stories = @scraper.top_articles(10)
      articles = HackerNews::ARTICLE.create_from_collection(stories)

      display_news(articles)

    when "3"
      HackerNews::ARTICLE.clear

      stories = @scraper.best_articles(10)
      articles = HackerNews::ARTICLE.create_from_collection(stories)

      display_news(articles)

    when "4"
      HackerNews::ARTICLE.clear

      stories = @scraper.show_articles(10)
      articles = HackerNews::ARTICLE.create_from_collection(stories)

      display_news(articles)
    when "5"
      puts "Please enter article ID:"

      input = gets.strip

      HackerNews::ARTICLE.clear

      story = HackerNews::SCRAPER.generate_article(input)


    when "6"
      puts "Please select what section you'd like to search \n 1. Top Posts \n 2. Newest \n 3. Show HN \n 4. Ask \n 5. jobs"

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

        articles = @scraper.top_articles(100)
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

        articles = @scraper.latest_articles(100)
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

        articles = @scraper.show_articles(100)
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

        articles = @scraper.ask_articles(100)
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

         articles = @scraper.job_articles(100)
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
    when "7"
      HackerNews::ARTICLE.clear

      articles = @scraper.top_articles(50)
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

      else
        puts "Please enter a valid menu selection"
        menu
      end
      menu
    end
  end

  def good_bye
    puts "Thanks for reading Hacker News!"
  end
end
