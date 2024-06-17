def subscribe_rss
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
        return rss_handler
      else
        puts '无法获取到正确的内容,请重新输入URL'
      end
    end
  end
end

class RssSubscriber
  def subscribe_rss
    loop do
      url = get_url

      if url_subscribed?(url)
        puts '这个RSS已经订阅过了,请输入新的订阅链接'
      else
        rss_handler = get_rss_handler(url)
        return rss_handler if valid_title?(rss_handler)
      end
    end
  end

  private

  def get_url
    puts '请输入RSS的订阅链接'
    gets.chomp.strip
  end

  def url_subscribed?(url)
    RssFeed.find_by_url(url)
  end

  def get_rss_handler(url)
    RSSHandler.new(url)
  end

  def valid_title?(rss_handler)
    title = rss_handler.rss_title
    if title
      puts "订阅的RSS为#{title}"
      true
    else
      puts '无法获取到正确的内容,请重新输入URL'
      false
    end
  end
end
