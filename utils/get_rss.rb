require 'nokogiri'
require 'open-uri'
require_relative 'rss_handler'

url = 'https://sspai.com/feed'
# url = 'https://www.geekpark.net/rss'

RSSHandler.new(url).handle
