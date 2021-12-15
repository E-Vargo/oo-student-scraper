require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url) 
    doc = Nokogiri::HTML(open(index_url))
    array = []
    doc.css("div.student-card").each do |s|
    hash = {name: s.css("h4.student-name").text, location: s.css("p.student-location").text, profile_url: s.css("a").attribute("href").value}
    array.push(hash)
    end
    array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    hash = {}
    hash = { profile_quote: doc.css("div.profile-quote").text, 
    bio: doc.css("div.bio-block").css("p").text}

    doc.css("div.social-icon-container").css("a").each do |e|

      if e.attribute("href").text.match(/twitter/)
        hash[:twitter] = e.attribute("href").text
      elsif e.attribute("href").text.match(/linkedin/)
        hash[:linkedin] = e.attribute("href").text
      elsif e.attribute("href").text.match(/github/)
        hash[:github] = e.attribute("href").text
      else 
        hash[:blog] = e.attribute("href").text
      end
    end

    #bio =  doc.css("div.bio-block").css("p").text
    #profile quote = doc.css("div.profile-quote").text
    #blog = doc.css("a").attribute("href").text
    #github = doc.css("a").attribute("href").text
    #linkedin = doc.css("a").attribute("href").text
    #twitter = doc.css("a").attribute("href").text
  hash
  
  end

end

