require 'HTTParty'
require 'Nokogiri'

class Scraper

  attr_accessor :parse_page

  def initialize
    doc = HTTParty.get("https://store.nike.com/sg/en_gb/pw/mens-nikeid-lifestyle-shoes/1k9Z7puZoneZoi3")
    @parse_page ||= Nokogiri::HTML(doc)
  end

  def get_names
    # names = parse_page.css(".grid-item-info").css(".product-name").css("p").children.map { |name| name.text }.compact
    names = item_container.css(".product-name").css("p").children.map { |name| name.text }.compact
  end
  def get_prices
    # prices = parse_page.css(".grid-item-info").css(".product-price").css("span.local").children.map { |price| price.text }.compact
    prices = item_container.css(".product-price").css("span.local").children.map { |price| price.text }.compact
  end

  private
  def item_container
    parse_page.css(".grid-item-info")
  end

  scraper = Scraper.new
  names = scraper.get_names
  prices = scraper.get_prices

  (0..prices.size).each do |index|
    puts "--- index: #{index + 1} ---"
    puts "Name: #{names[index]} | price: #{prices[index]}"
  end

end
