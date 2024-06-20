require 'active_record'

# rss url model
class RssUrl < ActiveRecord::Base
  belongs_to :rss_feed
end
