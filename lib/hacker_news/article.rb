class HackerNews::ARTICLE
  @@all = []
  attr_accessor :title, :type, :author, :time, :text, :url

  def initialize(article)
      # binding.pry
      article.each {|k, v| send(:"#{k}=", v)} unless article == nil

    @@all << self
  end

  # create, sort and query class methods
  class << self
      def create_from_collection(collection)
        articles = [ ]
        collection.each {|article| articles << self.new(article)}
        articles
      end

      def sort_by_name
        all.sort_by {|e| e.title.downcase}
      end

      def sort_by_author
        all.sort_by {|e| e.author.downcase}
      end

      def filter_by_type(type)
        all.select {|e| e.type == type}
      end

      def find_by_keyword(type, value)
        finder = filter_by_type(type).select do |e|
            e&.title&.downcase&.include?(value.downcase) || e&.text&.downcase&.include?(value.downcase)
          end
        finder.uniq
      end

      def find_by_title(title)
        all.select {|e| e.title.downcase == title.downcase}
      end

      def clear
        all.clear
      end

      def all
        @@all
      end
  end
end
