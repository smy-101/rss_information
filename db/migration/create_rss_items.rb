require_relative '../database'

# rss item model
class CreateRssItems < ActiveRecord::Migration[6.0]
  def change
    create_table :rss_items do |t|
      t.references :rss_feed, foreign_key: true
      t.string :title
      t.string :link
      t.text :content

      t.timestamps
    end
  end
end

CreateRssItems.new.change
