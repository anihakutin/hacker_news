# Demo UI...
class HackerNews::CLI

  def call
    list_news
    menu
    good_bye
  end

  def list_news #(args)
    puts "Teach Yourself to Echolocate: A beginner’s guide to navigating with sound \n
          link 'https://news.ycombinator.com/from?site=atlasobscura.com' \n
          337 point & 39 comments"
  end

  def menu
    input = null

    puts "1. Show recent news \n
          2. Show article with most comments \n
          3. Search for article \n
          4. Sort articles by source \n
          5. List comments"

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
