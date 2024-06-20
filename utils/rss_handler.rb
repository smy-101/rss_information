require 'nokogiri'
require 'open-uri'
require_relative '../model/rss_feed'

# parse the rss feed
class RSSParser
  attr_reader :title, :rss_url

  def initialize(url)
    @url = url
  end

  def parse_doc
    @doc = Nokogiri::XML(URI.parse(@url).open)
    handle_doc
  rescue StandardError => e
    puts "Error: #{e.message}"
    @doc = nil
  end

  def rss?
    # RSS feeds usually have a <channel> element
    return true if @doc.at_xpath('//channel')

    # Atom feeds usually have a <feed> element
    return true if @doc.at_xpath('//feed')

    false
  rescue StandardError => e
    puts "Error: #{e.message}"
    false
  end

  private

  def handle_doc
    return unless @doc

    case @doc.root.name
    when 'rss'
      handle_rss
    when 'feed'
      handle_atom
    else
      puts 'Unknown format'
    end
  end

  def extract_data_from_item(item)
    {
      title: item.at_xpath('title').content,
      link: item.at_xpath('link').content,
      description: item.at_xpath('description').content,
      pubDate: item.at_xpath('pubDate').content
    }
  end

  def handle_rss
    @title = @doc.at_xpath('//channel/title').content
    @rss_url = @doc.at_xpath('//channel/link').content
    @items = @doc.xpath('//item').map { |item| extract_data_from_item(item) }
  end

  def handle_atom
    @items = []
    @doc.xpath('//entry').each do |entry|
      @title = entry.at_xpath('title').content
      @link = entry.at_xpath('link')['href']
      @items << entry
    end
  end
end

# check the url
class URLChecker
  def exist?(url)
    RssFeed.find_by_url(url)
  end
end

# format the rss feed
class RSSHandler
  def initialize(url)
    @url = url
    @rss_parser = RSSParser.new(url)
    @url_checker = URLChecker.new
  end

  def valid_rss_url?
    @rss_parser.parse_doc
    return false unless @rss_parser.rss?

    puts @rss_parser.rss_url
    false if @url_checker.exist?(@rss_parser.rss_url)
  end

  def add_rss_url
    print_subscription_prompt
    subscribe_if_confirmed
  end

  private

  def print_subscription_prompt
    puts "订阅的RSS为#{@rss_parser.title}"
    puts '是否要订阅这个RSS?(y/n)'
  end

  def subscribe_if_confirmed
    return puts '取消订阅' unless gets.chomp == 'y'

    rss_feed = RssFeed.create(url: @rss_parser.rss_url, title: @rss_parser.title)
    rss_feed.persisted? ? puts('订阅成功') : print_errors(rss_feed)
  end

  def print_errors(rss_feed)
    puts "Errors: #{rss_feed.errors.messages}"
  end
end
