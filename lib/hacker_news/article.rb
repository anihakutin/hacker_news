class HackerNews::ARTICLE
  @@all = []
  attr_accessor :title,
                :id,
                :type,
                :author,
                :time,
                :text,
                :url,
                :parent,
                :descendants,
                :kids

  def initialize(article)
    article.each {|k, v| send(:"#{k}=", v)}

    @@all << self
  end

  # Class methods
  class << self
      # Takes hash and creates and returns article objects
      def create_from_collection(collection)
        collection.map {|article| self.find_or_create(article)}
      end

      # returns a single article
      def find_or_create(article)
        finder = self.find_by_id(article[:id])
        finder = self.new(article) unless finder != nil
        finder
      end

      def find_by_id(id)
        all.find {|e| e.id == id}
      end

      # Returns sorted objects
      def sort_by_name
        all.select {|e| !e.title.nil? }.sort_by {|e| e.title.downcase}
      end
      # Returns sorted objects
      def sort_by_author
        all.select {|e| e.author != nil }.sort_by {|e| e.author.downcase}
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
      #returns kid id's by parent id on invalid return nil
      def kids_by_id(id)
        comments = [ ]
        parent = all.select {|e| e.id.to_s == id}
        comments << parent&.first&.kids
        comments << parent&.first&.descendants
        comments
      end

      def all
        @@all
      end
  end
end
