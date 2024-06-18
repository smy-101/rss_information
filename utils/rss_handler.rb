require 'nokogiri'
require 'open-uri'

# format the rss feed
class RSSHandler
  def initialize(url)
    @doc = Nokogiri::XML(URI.parse(url).open)
  rescue StandardError
    # puts "Failed to open URL: #{e.message}"
    @doc = nil
  end

  def handle
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

  def rss_title
    return nil unless @doc

    title_element = @doc.xpath('//channel/title').first
    if title_element.nil?
      nil
    else
      title_element.content
    end
  end

  private

  def handle_rss
    @doc.xpath('//item').each do |item|
      title = item.at_xpath('title').content
      link = item.at_xpath('link').content
      [title, link, item]
      puts [title, link, item]
    end
  end

  def handle_atom
    @doc.xpath('//entry').each do |entry|
      title = entry.at_xpath('title').content
      link = entry.at_xpath('link')['href']
      [title, link, item]
      puts [title, link, item]
    end
  end
end
