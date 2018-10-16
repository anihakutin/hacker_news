# To Do
# refactor menu
# query author
# display show, ask, jobs
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
    # User input
    input = nil
    # Welcome message
    puts "\n"
    puts "Welcome to hacker news!"
    puts "Enter the number of the menu option you'd like to see, or type exit to exit:"
    puts " 1. Show ten mosts recent posts \n 2. Show ten top posts \n 3. Search for article(in top 200) \n 4. Sort articles by Title/Author \n 5. List comments \n "
    # Get input
    input = gets.strip.downcase
    # Proccess input
    if input != "exit"
      case input

      when "1"
        # Clear all articles
        HackerNews::ARTICLE.clear
        # Get articles
        stories = HackerNews::SCRAPER.new.latest_articles(10)
        # Create article objects
        articles = HackerNews::ARTICLE.create_from_collection(stories)
        # Display articles to user
        display_news(articles)

      when "2"
        # Clear all articles
        HackerNews::ARTICLE.clear
        # Get articles
        stories = HackerNews::SCRAPER.new.top_articles(10)
        # Create article objects
        articles = HackerNews::ARTICLE.create_from_collection(stories)
        # Display articles to user
        display_news(articles)

      when "3"
        puts "Please select what section you'd like to search \n 1. News \n 2. Top Posts \n 3. Show HN \n 4. Jobs"
        sec_input = gets.strip.downcase

        case sec_input
          when "1"
            puts "Please enter your keyword"
            third_input = sec_input = gets.strip.downcase
              # Clear all articles
              HackerNews::ARTICLE.clear
              # Get articles
              articles = HackerNews::SCRAPER.new.top_articles(20)
              # Create article objects
              HackerNews::ARTICLE.create_from_collection(articles)
              # Find article requested by user
              articles = HackerNews::ARTICLE.find_by_keyword("story", third_input)
              # Display result to user
              if !articles.empty?
                   display_news(articles)
                 else
                   puts "No matching keywords found \n"
                   menu
               end

          when "2"

          when "3"

          when "4"

          else
            puts "Please enter a valid menu selection"
            menu
        end
      when "4"
        # -- Preload articles --
        #
        # Clear all articles
        HackerNews::ARTICLE.clear
        # Get articles
        articles = HackerNews::SCRAPER.new.top_articles(50)
        # Create article objects
        HackerNews::ARTICLE.create_from_collection(articles)
        # Display user options
        puts "Please enter how you would like to sort the News articles(by 1. Title, 2. Author)"
        # Get user input
        input = gets.strip.downcase
        # Process input
        case input
          when "1"
            # Find article requested by user
            articles = HackerNews::ARTICLE.sort_by_name
            # Display articles to user
            display_news(articles)
          when "2"
            # Find article requested by user
            articles = HackerNews::ARTICLE.sort_by_author
            # Display articles to user
            display_news(articles)
          else
            puts "Please enter a valid menu selection"
            menu
        end
      when "5"

      else
        puts "Please enter a valid menu selection"
        #show the menu again
        menu
      end
    end
  end

  def good_bye
    puts "Thanks for reading Hacker News!"
  end
end
