require_relative '../database'

# rss feed model
class CreateRssFeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :rss_feeds do |t|
      t.string :name

      t.timestamps
    end
  end
end
