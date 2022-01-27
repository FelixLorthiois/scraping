require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
 
# Given a townhall_url, return the email of the town
def get_townhall_email(townhall_url)
  
  # loads the page of the townhall
  page = Nokogiri::HTML(URI.open(townhall_url))

  # gets the email of the townhall
  email = page.xpath("//section[2]//tbody[1]/tr[4]/td[2]").text
  return email
end

def townhall_scraper
  # loads the page of all townhalls of Val d oise
  page = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/val-d-oise.html"))

  # get the number of towns
  town_number = page.xpath("//a[@class = 'lientxt']").length
  puts "#{town_number} cities have been identified on the website"

  # initializing the output: an array of hash. Each hash contains as key the name of the town and as value the email of the townhall
  array_of_hash_towns = []

  # at each step of the loop, we scrap the name of the town, the townhall_url and then the townhall email
    town_number.times do |i|
    town_name = page.xpath("//a[@class = 'lientxt']")[i].text
    townhall_url = "https://www.annuaire-des-mairies.com" + page.xpath("//a[@class = 'lientxt']/@href")[i].text[1..-1]
    townhall_email = get_townhall_email(townhall_url)
    
    hash_town = {town_name => townhall_email}       # wraps-up in a hash
    array_of_hash_towns << hash_town                # includes the hash in output array
    puts "email of #{town_name} has been scraped and stored"
  end
  return array_of_hash_towns
end
