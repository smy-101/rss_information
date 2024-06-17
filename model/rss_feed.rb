require 'active_record'

# rss feed model
class RssFeed < ActiveRecord::Base
  has_many :rss_items

  def self.find_by_url(url)
    where(url: url).first
  end
end
