require 'nokogiri'
require 'open-uri'
require_relative '../model/rss_feed'

# format the rss feed
class RSSHandler
  def initialize(url)
    @url = url
  end

  def add_check?
    return false if exist?

    parse_doc
    return false unless rss?

    true
  end

  def add_rss_url
    print_subscription_prompt
    subscribe_if_confirmed
  end

  private

  def exist?
    RssFeed.find_by_url(@url)
  end

  def rss?
    # RSS feeds usually have a <channel> element
    return true if @doc.at_xpath('//channel')

    # Atom feeds usually have a <feed> element
    return true if @doc.at_xpath('//feed')

    false
  rescue StandardError
    false
  end

  def parse_doc
    @doc = Nokogiri::XML(URI.parse(url).open)
    handle_doc
  rescue StandardError
    @doc = nil
  end

  def print_subscription_prompt
    puts "订阅的RSS为#{@title}"
    puts '是否要订阅这个RSS?(y/n)'
  end

  def subscribe_if_confirmed
    return puts '取消订阅' unless gets.chomp == 'y'

    rss_feed = RssFeed.create(url: @url, title: @title)
    rss_feed.persisted? ? puts('订阅成功') : print_errors(rss_feed)
  end

  def print_errors(rss_feed)
    puts "Errors: #{rss_feed.errors.messages}"
  end

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

  def handle_rss
    @items = []
    @doc.xpath('//item').each do |item|
      @title = item.at_xpath('title').content
      @link = item.at_xpath('link').content
      @items << item
    end
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
