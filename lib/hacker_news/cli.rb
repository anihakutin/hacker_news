# Demo UI...
class HackerNews::CLI

  def call
    menu
    good_bye
  end

  def display_news(articles = HackerNews::SCRAPER.new.latest_articles(10))
    puts "----What you ask is what you get...---- \n"

    # request 10 latest_articles
    HackerNews::ARTICLE.create_from_collection(articles)

    # Print article objects
    HackerNews::ARTICLE.all.each do |x|
      puts "#{x.title} by #{x.author}"
      puts "Link #{x.url}"
      puts "#{x.text}"
    end
    puts "------------------------ \n"
  end

  def menu
    puts "Welocme to hacker news!"
    puts "Enter the number of the menu option you'd like to see, or type exit to exit:"
    input = nil
    puts " 1. Show ten mosts recent posts \n 2. Show ten top posts \n 3. Search for article(in top 200) \n 4. Sort articles by source \n 5. List comments \n "

    input = gets.strip.downcase
    if input != "exit"
      case input
      when "1"
        articles = HackerNews::SCRAPER.new.latest_articles(10)
        display_news(articles)
      when "2"
        articles = HackerNews::SCRAPER.new.top_articles(10)
        display_news(articles)
      when "3"
        puts "Please select what section you'd like to search \n 1. News \n 2. Top Posts \n 3. Show HN \n 4. Jobs"
        sec_input = gets.strip.downcase
        case sec_input
          when "1"
            puts "Please enter your keyword"
            third_input = sec_input = gets.strip.downcase
            articles = HackerNews::SCRAPER.new.top_articles(50)
            HackerNews::ARTICLE.create_from_collection(articles)
            HackerNews::SCRAPER.find_by_value("story", third_input)
            display_news(articles)
          when "2"

          when "3"

          when "4"

          else
            puts "Please enter a valid menu selection"
        end
      when "4"

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
