require 'active_record'
require 'stringio'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'rss_feeds.sqlite'
)

sio = StringIO.new
ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, sio)
File.open('db/schema.rb', 'w') { |f| f.write(sio.string) }
