# Demo UI...
class HackerNews::CLI

  def call
    list_news
    menu
    good_bye
  end

  def list_news #(args)
    puts "Welocme to hacker news! \n"
    puts "--------------------------"
    # test code -----------
    top_stories = HackerNews::SCRAPER.new.get_stories
    top_stories.each do |x|
      puts "#{x[:title]} by #{x[:by]}"
      puts "Link #{x[:url]}"
      puts "#{x[:text]}"
    end
    # ---------------------
    puts "----Latest Articles----"

    puts "------------------------ \n"
  end

  def menu
    input = nil
    puts " 1. Show recent news \n 2. Show article with most comments \n 3. Search for article \n 4. Sort articles by source \n 5. List comments \n Please enter a menu option:"

    input = gets.chomp
    if input != "exit"
      case input
      when "1"

      when "2"

      when "3"

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
