require 'nokogiri'
require 'open-uri'

MAX_PAGES = 100

next_link = 'http://userscripts-mirror.org/scripts.html'

script_links = []

(1..MAX_PAGES).each do |page_number|
  userscripts_xml = open(next_link)

  starting_page = Nokogiri::HTML(userscripts_xml)

  script_links << starting_page.to_s.scan(/^.*script.*class="title".*$/).map {|line|
    line.match(/href="(?<href>.*?)"/)[:href]
  }

  next_link = "http://userscripts-mirror.org/#{starting_page.css('a.next_page').attr('href')}"
  sleep 0.125
end

puts script_links.flatten.join(', ')