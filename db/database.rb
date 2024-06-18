require 'active_record'
require 'stringio'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'sqlite_dbs/rss_feeds.sqlite'
)
