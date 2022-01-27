require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
 
# opens and loads the online page with nokogiri
def open_url
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
end

def select_crypto_names(page)
  crypto_names = page.xpath("//td[@class = 'cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--hide-sm cmc-table__cell--sort-by__symbol']/div")
  return crypto_names
end

def select_crypto_values(page)
  crypto_values = page.xpath("//td[@class = 'cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price']//span")
  return crypto_values
end

def name_extract(node_set)
  array = []
  array = node_set.map {|node| node.text}
  return array
end

def value_extract(node_set)
  array = []
  array = node_set.map {|node| node.text[1..-1].gsub(",","").to_f}
  return array
end

def array_of_ashes_create(key_array,value_array)
  hash = Hash.new
  array_of_ashes = []
  key_array.each_index do |index|
    hash = {key_array[index] => value_array[index]}
    array_of_ashes << hash
  end
  return array_of_ashes
end

def crypto_scraper
  page = open_url
  crypto_names_node_set = select_crypto_names(page)
  array_crypto_names = name_extract(crypto_names_node_set)
  crypto_values_node_set = select_crypto_values(page)
  array_crypto_values = value_extract(crypto_values_node_set)
  crypto_array_of_ashes = array_of_ashes_create(array_crypto_names,array_crypto_values)
  puts crypto_array_of_ashes
  return crypto_array_of_ashes
end