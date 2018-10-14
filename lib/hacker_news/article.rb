class HackerNews::ARTICLE
  @@All = []
  attr_accessor :title, :author, :time, :text, :url

  def initialize(stories)
    stories.each {|k, v| send(:"#{k}=", v)}

    @@All << self
  end

  
end
