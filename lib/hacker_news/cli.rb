class HackerNews::CLI

  def call
    @api_connector = HackerNews::API_CONNECTOR.new

    menu
    good_bye
  end

  def menu
    input = nil
    welcome_msg
    input = gets.strip.downcase

    if input != "exit"
      case input
      when "1"
        latest_articles
        menu
      when "2"
        top_articles
        menu
      when "3"
        best_articles
        menu
      when "4"
        show_articles
        menu
      when "5"
        get_comments
        menu
      when "6"
        find_by_keyword
        menu
      when "7"
        sort_by_selection
        menu
      else
        invalid_input(1)
        menu
      end
    end
  end

  def welcome_msg
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
          7. Sort top ten articles by Title/Author
    STRING
  end

  def display_news(articles)
    puts "\n ----You ask, you get...---- \n\n"

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

  def latest_articles
    stories = @api_connector.latest_articles
    articles = HackerNews::ARTICLE.create_from_collection(stories)
    display_news(articles)
  end

  def top_articles
    stories = @api_connector.top_articles
    articles = HackerNews::ARTICLE.create_from_collection(stories)
    display_news(articles)
  end

  def best_articles
    stories = @api_connector.best_articles
    articles = HackerNews::ARTICLE.create_from_collection(stories)
    display_news(articles)
  end

  def show_articles
    stories = @api_connector.show_articles
    articles = HackerNews::ARTICLE.create_from_collection(stories)
    display_news(articles)
  end

  def get_comments
    puts "Please enter article ID:"
    input = gets.strip
    kids = HackerNews::ARTICLE.kids_by_id(input)

    if kids.first == nil
      puts "Invalid article ID, you must first load articles in order to get it's comments"
    else
      stories = @api_connector.get_comments(kids.first, kids.last)

      articles = HackerNews::ARTICLE.create_from_collection(stories)
      display_news(articles.select{|a| !a.author.nil?})
    end
  end

  def find_by_keyword
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
      articles = @api_connector.top_articles
      HackerNews::ARTICLE.create_from_collection(articles)
      articles = HackerNews::ARTICLE.find_by_keyword("story", input)

      if !articles.empty?
         display_news(articles)
      else
         invalid_input(2)
         menu
      end
    when "2"
      puts "Please enter your keyword"
      input = gets.strip.downcase

      articles = @api_connector.latest_articles
      HackerNews::ARTICLE.create_from_collection(articles)
      articles = HackerNews::ARTICLE.find_by_keyword("story", input)

      if !articles.empty?
         display_news(articles)
       else
         invalid_input(2)
         menu
      end
    when "3"
      puts "Please enter your keyword"
      input = gets.strip.downcase
      articles = @api_connector.show_articles
      HackerNews::ARTICLE.create_from_collection(articles)
      articles = HackerNews::ARTICLE.find_by_keyword("story", input)

      if !articles.empty?
         display_news(articles)
       else
         invalid_input(2)
         menu
      end
    when "4"
      puts "Please enter your keyword"
      input = gets.strip.downcase

      articles = @api_connector.ask_articles
      HackerNews::ARTICLE.create_from_collection(articles)
      articles = HackerNews::ARTICLE.find_by_keyword("story", input)

      if !articles.empty?
         display_news(articles)
       else
         invalid_input(2)
         menu
      end
    when "5"
       puts "Please enter your keyword"
       input = gets.strip.downcase

       articles = @api_connector.job_articles
       HackerNews::ARTICLE.create_from_collection(articles)
       articles = HackerNews::ARTICLE.find_by_keyword("job", input)

       if !articles.empty?
          display_news(articles)
       else
          invalid_input(2)
          menu
       end
      else
        invalid_input(1)
        menu
      end
  end

  def sort_by_selection
    articles = @api_connector.top_articles
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
        invalid_input(1)
        menu
      end
  end

  def invalid_input(msg = 1)
    case msg
    when 1
      puts "Please enter a valid menu selection"
    when 2
      puts "No matching keywords found \n"
    end
  end

  def good_bye
    puts "Thanks for reading Hacker News!"
  end
end
