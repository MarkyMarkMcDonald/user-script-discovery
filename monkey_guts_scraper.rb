require 'nokogiri'
require 'open-uri'

require './db_connector'

1.times.map do |index|
  offset = index * 30
  monkey_guts_url = "https://monkeyguts.com/index.php?offset=#{offset}"
  monkey_guts_page = Nokogiri::HTML(open(monkey_guts_url))
  ids = monkey_guts_page.css('.browse .row').map { |row| row.attr('id') }

  script_links = ids.map { |id| "https://monkeyguts.com/codepages/#{id}.user.js" }
  script_links.each do |script_link|
    code = Nokogiri::HTML(open(script_link)).css('body p').first.text
    includes = code.lines.select { |line| line =~ /\/\/ @include/ }
    excludes = code.lines.select { |line| line =~ /\/\/ @exclude/ }

    Script.create(includes: includes, excludes: excludes, source: 'monkey_guts', link: script_link )
  end
end
