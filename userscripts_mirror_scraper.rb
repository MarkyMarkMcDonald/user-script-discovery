require 'nokogiri'
require 'open-uri'

starting_url = 'http://userscripts-mirror.org/scripts.html'

starting_page = Nokogiri::XML(open(starting_url)) do |config|
  config.options = Nokogiri::XML::ParseOptions::NOERROR | Nokogiri::XML::ParseOptions::NONET
end

script_links = starting_page.css('tbody tr .script-meat a').map { |script| script.attr('href') }

next_link = starting_page.css('a.next_page').attr('href')

puts script_links.length
puts next_link

