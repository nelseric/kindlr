require 'capybara'
require 'capybara/dsl'
require 'capybara-webkit'

require 'pry'

Capybara.run_server = false
Capybara.current_driver = :webkit
Capybara.app_host = 'http://read.amazon.com/'
Capybara::Webkit.configure do |config|
  config.allow_url('*amazon.com')
  config.allow_url('*amazonaws.com')
end

module Kindlr
  class Spider
    include Capybara::DSL

    def books
      retries = 0
      begin
        Timeout.timeout(Capybara.default_max_wait_time * 2) do
          while @books.nil? || @books.empty?
            @books = find_all :xpath, "/html/body/div[@id='page_body']/div[@id='page_body_content_containers']/div[@id='slide_container']/div[@id='titles_container']/div[@id='titles_inner_wrapper']/*"
          end
        end
      rescue Timeout::Error
        retries += 1
        if retries > 3
          raise 'Could not load books'
        else
          retry
        end
      end
      @books.map { |elem| Book.new self, elem }
    end

    def initialize
      page.driver.header('user-agent', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.32 Safari/537.36')
      visit('/')
      fill_in 'ap_email', with: 'gauntletguy2@gmail.com'
      fill_in :ap_password, with: 'qy5ir8zp3re6'
      click_button 'Sign In'
      find('#kindle_dialog_firstRun_button').click
    end

    def read_book(book_id)
      find("##{book_id}").click
    end
  end
end
