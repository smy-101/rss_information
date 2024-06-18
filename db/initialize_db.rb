require_relative './migration/create_rss_feeds'
require_relative './migration/create_rss_items'
require_relative './database'
require 'stringio'

CreateRssFeeds.new.change
CreateRssItems.new.change

sio = StringIO.new
ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, sio)
File.open('db/schema.rb', 'w') { |f| f.write(sio.string) }
