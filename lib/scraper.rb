require 'open-uri'
require 'pry'
require 'nokogiri'


class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    student_profiles = [] 
    profiles = page.css("div.roster-cards-container div.student-card a")
    profiles.each do |info|
      student_profiles << {
        name: info.css(".student-name").text, 
        location: info.css(".student-location").text, 
        profile_url: "#{info.attr('href')}"
      }
    end
    student_profiles
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

