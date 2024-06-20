require_relative 'db/database'
require_relative 'model/rss_feed'
require_relative 'utils/rss_handler'

loop do
  puts '请输入RSS的订阅链接'
  url = gets.chomp.strip

  rss_handler = RSSHandler.new(url)
  if rss_handler.valid_rss_url?
    # rss_handler.add_rss_url
    puts '11111111'
  else
    puts 'RSS链接已添加或者不是一个有效的RSS链接'
  end
end
