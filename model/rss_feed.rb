require 'active_record'

# rss feed model
class RssFeed < ActiveRecord::Base
  has_many :rss_items, :rss_urls

  validates :url, :name, presence: true

  def self.find_by_url(url)
    where(url: url).first
  end
end
