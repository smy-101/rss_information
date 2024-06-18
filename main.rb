require_relative 'db/database'
require_relative 'model/rss_feed'
require_relative 'utils/rss_handler'

loop do
  puts '请输入RSS的订阅链接'
  url = gets.chomp.strip

  # 判断这个url是否与数据库的中的数据重合
  rss_feed = RssFeed.find_by_url(url)
  if rss_feed
    puts '这个RSS已经订阅过了,请输入新的订阅链接'
  else
    rss_handler = RSSHandler.new(url)
    title = rss_handler.rss_title
    if title
      puts "订阅的RSS为#{title}"
      puts '是否要订阅这个RSS?(y/n)'
      if gets.chomp == 'y'
        rss_handler.add_rss_url(url)
        # TODO: 将这个url存入数据库
        puts '订阅成功'
      else
        puts '取消订阅'
      end
      break
    else
      puts '无法获取到正确的内容,请重新输入URL'
    end
  end
end
