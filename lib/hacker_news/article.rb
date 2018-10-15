class HackerNews::ARTICLE
  @@all = []
  attr_accessor :title, :type, :author, :time, :text, :url

  def initialize(article)
      # binding.pry
      article.each {|k, v| send(:"#{k}=", v)} unless article == nil

    @@all << self
  end

  # Class methods
  class << self
      # Takes hash and creates and returns article objects
      def create_from_collection(collection)
        articles = [ ]
        collection.each {|article| articles << self.new(article)}
        articles
      end
      # Returns sorted objects
      def sort_by_name
        all.sort_by {|e| e.title.downcase}
      end
      # Returns sorted objects
      def sort_by_author
        all.sort_by {|e| e.author.downcase}
      end
      # Returns filtered object's results
      def filter_by_type(type)
        all.select {|e| e.type == type}
      end
      # Allows the user to search for articles by keyword
      def find_by_keyword(type, value)
        finder = filter_by_type(type).select do |e|
            e&.title&.downcase&.include?(value.downcase) || e&.text&.downcase&.include?(value.downcase)
          end
      # Returns articles and removes duplicates //fixme
        finder.uniq
      end

      def find_by_author(author)
        all.select {|e| e.author.downcase == author.downcase}
      end

      def clear
        all.clear
      end

      def all
        @@all
      end
  end
end
