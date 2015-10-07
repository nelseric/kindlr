module Kindlr
  class Book
    attr_reader :title, :author, :id

    def initialize(scraper, elem)
      @scraper = scraper

      @title, @author = elem.all(:xpath, 'div[2]/*').map(&:text)
      @id = elem.path.match(/@id=\'(B\w+)\'/)[1]
    end
  end
end
