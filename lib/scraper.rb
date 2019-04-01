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
        :name => info.css(".student-name").text, 
        :location => info.css(".student-location").text, 
        :profile_url => "#{info.attr('href')}"
      }
    end
    student_profiles
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    student_profile = {}
    social_links = page.css(".social-icon-container").children.css("a").collect{|link| link.attribute("href").value}
    social_links.each do |link|
      if link.include?("linkedin")
        student_profile[:linkedin] = link 
      elsif link.include?("github")
        student_profile[:github] = link 
      elsif link.include?("twitter")
        student_profile[:twitter] = link 
      else 
        student_profile[:blog] = link 
      end 
    end 
    student_profile[:profile_quote] = page.css(".profile-quote").text 
    student_profile[:bio] = page.css(".description-holder p").text
    student_profile
  end

end

