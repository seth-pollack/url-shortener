
Url.destroy_all

urls = %w(http://www.linkedin.com/in/pollackseth/en 
					http://www.beenverified.com/ 
					http://sethpollack.net/ 
					http://sethpollack.net/opensource/
					https://github.com/sethpollack
					https://twitter.com/seth_pollack
					)

urls.each { |url| Url.create(link: url) }

Url.all.each do |url|
	(1..10).to_a.sample.times do
		url.visits << Visit.create(ip: Faker::Internet.ip_v4_address, referer: Faker::Internet.url)
	end
	url.save
end