require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

# returns an array containing the urls of the deputies
def get_deputy_urls 
  # loads the page containing the urls of all deputies as links
  page = Nokogiri::HTML(URI.open("https://www.nosdeputes.fr/deputes"))

  # gets the links to the deputy urls
  urls_nodes = page.xpath("//div[@class = 'liste']//td//a/@href")

  # stores the urls in an array and returns this array
  array_urls = []
  array_urls = urls_nodes.map {|node| "https://www.nosdeputes.fr" + node.text}
  return array_urls
end

# returns a hash containing deputy firstname, lastname and email
def hash_deputy_creator(deputy_url)
  # loads the page of the deputy
  page = Nokogiri::HTML(URI.open(deputy_url))
  # gets the email of the deputy
  email = page.xpath("//*[@id='b1']/ul[2]/li[1]/ul/li[1]/a/@href").text[7..-1]
  # gets the firstname of the deputy
  firstname = page.xpath("//h1").text.split[0]
  # gets the lastname of the deputy
  lastname = page.xpath("//h1").text.split[1]
  # builds the hash using symbols as keys
  hash_deputy = { first_name: firstname, last_name: lastname, email: email }
end

# perform
def perform
  array_of_hash_deputies = []
  array_urls = get_deputy_urls
  puts "All deputy urls have been scraped"
  array_urls.each do |url|
    hash_deputy = hash_deputy_creator(url)
    puts "email of deputy #{hash_deputy[:last_name]} has been scraped"
    array_of_hash_deputies << hash_deputy

    # uncomment this below loop to stop at ten deputies...
    # if array_of_hash_deputies.length == 10
    #  puts "\n Voici les emails des députés:"
    #  puts array_of_hash_deputies
    #  return array_of_hash_deputies
    # end

  end
  puts "\nVoici les emails des députés:"
  puts array_of_hash_deputies
end

perform
