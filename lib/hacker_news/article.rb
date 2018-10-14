class HackerNews::ARTICLE
  @@all = []
  attr_accessor :title, :type, :author, :time, :text, :url

  def initialize(posts)
    posts.each {|k, v| send(:"#{k}=", v)}

    @@all << self
  end

  # create, sort and query class methods
  class << self
      def create_from_collection(collection)
        collection.each {|article| self.new(article)}
      end

      def sort_by_name

      end

      def sort_by_author

      end

      def filter_by_type(type)
        all.select {|x| x.type == type}
      end

      def find_by_value(type, value)
        # fixme "Check for nil properties"
        binding.pry
        filter_by_type(type).select do |x|
            if x.title.include?(value) || x.text.include?(value)
              true
            else
              false
            end
          end
      end

      def all
        @@all
      end
  end
end
