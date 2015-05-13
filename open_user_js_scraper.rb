require 'nokogiri'
require 'open-uri'

require './db_connector'

class OpenUserJsScraper

  MAX_PAGES = 65

  def scrape
    (1..MAX_PAGES).each do |page_number|
      links_to_script_sources(page_number).each do |script_link|
        script_source = parse_script_source(script_link)

        description = parse_description(script_source)

        puts "persisting #{script_link}"
        script = Script.create(source: 'open_user_js', link: script_link, content: script_source, description: description)

        includes = parse_inclusions(script_source)
        includes.each do |inclusion|
          Inclusion.create(pattern: inclusion, script_id: script.id)
        end

        excludes = parse_exclusions(script_source)
        excludes.each do |exclusion|
          Exclusion.create(pattern: exclusion, script_id: script.id)
        end
      end
    end
  end

  private

  def parse_description(script_source)
    description_line = script_source.lines.find { |line| line =~ /\/\/ @description/ }
    description_line ? description_line.split('@description').last : ''
  end

  def parse_script_source(script_link)
    begin
      Nokogiri::XML(open(script_link)).css('#editor').text
    rescue Exception => e
      puts e
      puts "skipping script #{script_link}"
      ''
    end
  end

  def parse_exclusions(script_source)
    script_source.lines.select { |line| line =~ /\/\/ @exclude/ }.map(&:split).map(&:last).map { |exclude| exclude.gsub('%', '\%').gsub('*', '%') }
  end

  def parse_inclusions(script_source)
    script_source.lines.select { |line| line =~ /\/\/ @include/ }.map(&:split).map(&:last).map { |include| include.gsub('%', '\%').gsub('*', '%') }
  end

  def links_to_script_sources(page_number)
    puts "processing page #{page_number}"
    begin
      starting_url = "https://openuserjs.org/?p=#{page_number}"
      starting_page = Nokogiri::XML(open(starting_url))

      starting_page.css('.col-sm-8 .tr-link a.tr-link-a').map { |script| 'https://openuserjs.org' + script.attr('href') + '/source' }
    rescue Exception => e
      puts e
      puts "skipping page #{page_number}"
      []
    end
  end

end

