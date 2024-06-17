require 'active_record'

# rss item model
class RssItem < ActiveRecord::Base
  belongs_to :rss_feed
end
