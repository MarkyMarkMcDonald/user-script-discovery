require 'nokogiri'
require 'open-uri'

require './db_connector'

65.times.each do |page_number|
  offset_page_number = page_number + 1

  begin
    starting_url = "https://openuserjs.org/?p=#{offset_page_number}"
    starting_page = Nokogiri::XML(open(starting_url))

    script_links = starting_page.css('.col-sm-8 .tr-link a.tr-link-a').map { |script| 'https://openuserjs.org' + script.attr('href') + '/source' }
  rescue Exception => e
    puts e
    puts "skipping page #{offset_page_number}"
    next
  end

  puts "processing page #{offset_page_number}"
  script_links.each do |script_link|
    begin
      code = Nokogiri::XML(open(script_link)).css('#editor').text
      includes = code.lines.select { |line| line =~ /\/\/ @include/ }.map(&:split).map(&:last).map {|include| include.gsub('%', '\%').gsub('*', '%') }
      excludes = code.lines.select { |line| line =~ /\/\/ @exclude/ }.map(&:split).map(&:last).map {|exclude| exclude.gsub('%', '\%').gsub('*', '%') }
    rescue Exception => e
      puts e
      puts "skipping script #{script_link}"
      next
    end

    puts "persisting #{script_link}"
    Script.create(includes: includes, excludes: excludes, source: 'open_user_js', link: script_link )
  end
end
