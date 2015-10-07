require 'thor'

require 'table_print'

module Kindlr
  class CLI < Thor
    desc 'main', 'Run Kindlr'
    def main
      spider = Kindlr::Spider.new
      books = spider.books.sort_by(&:author)

      tp books, :id, { title: { width: 100 } }, :author
    end

    desc 'read BookID', 'Read a book specified by BookID'
    def read(book_id)
      spider = Kindlr::Spider.new
      spider.read_book book_id
    end

    default_task :main
  end
end
