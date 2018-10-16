class HackerNews::CLI

  def call
    menu
    good_bye
  end

  def display_news(articles)
    puts "\n ----You ask, you get...---- \n\n"
    # Print article objects
    articles.each do |x|
      puts "#{x.title} by #{x.author}"
      puts "Link #{x.url}"
      puts "#{x.text}"
    end

    puts "------------------------ \n"

  end

  def menu
    input = nil

    puts "\n"
    puts "Welcome to hacker news!"
    puts "Enter the number of the menu option you'd like to see, or type exit to exit:"
    puts " 1. Show ten newest posts \n 2. Show ten top posts \n 3. Show ten best posts \n 4. Show ten 'show HN' posts \n 5. Search for article(in top 200) \n 6. Sort articles by Title/Author \n"

    input = gets.strip.downcase

  if input != "exit"
    case input
    when "1"
      # Clear all articles
      # Get articles
      # Create article objects
      # Display articles to user
      HackerNews::ARTICLE.clear\

      stories = HackerNews::SCRAPER.new.latest_articles(10)
      articles = HackerNews::ARTICLE.create_from_collection(stories)

      display_news(articles)

    when "2"
      HackerNews::ARTICLE.clear

      stories = HackerNews::SCRAPER.new.top_articles(10)
      articles = HackerNews::ARTICLE.create_from_collection(stories)

      display_news(articles)

    when "3"
      HackerNews::ARTICLE.clear

      stories = HackerNews::SCRAPER.new.best_articles(10)
      articles = HackerNews::ARTICLE.create_from_collection(stories)

      display_news(articles)

    when "4"
      HackerNews::ARTICLE.clear

      stories = HackerNews::SCRAPER.new.show_articles(10)
      articles = HackerNews::ARTICLE.create_from_collection(stories)

      display_news(articles)

    when "5"
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

        articles = HackerNews::SCRAPER.new.top_articles(100)
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

        articles = HackerNews::SCRAPER.new.latest_articles(100)
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

        articles = HackerNews::SCRAPER.new.show_articles(100)
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

        articles = HackerNews::SCRAPER.new.ask_articles(100)
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

         articles = HackerNews::SCRAPER.new.job_articles(100)
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
    when "6"
      HackerNews::ARTICLE.clear

      articles = HackerNews::SCRAPER.new.top_articles(50)
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
    end
  end

  def good_bye
    puts "Thanks for reading Hacker News!"
  end
end
