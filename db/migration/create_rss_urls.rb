require_relative '../database'

# rss url model
class CreateRssUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :rss_urls do |t|
      t.string :url
      t.boolean :is_original
      t.references :rss_feed, foreign_key: true

      t.timestamps
    end
  end
end
