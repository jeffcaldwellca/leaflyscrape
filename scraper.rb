# require 'sinatra'
require 'nokogiri'
require 'HTTParty'

class Scraper

  attr_accessor :content

  def initialize
    type = "hybrid"
    name = "xj-13"
    site = HTTParty.get("https://www.leafly.com/#{type}/#{name}")
    @content ||= Nokogiri::HTML(site)
  end

  def get_description
    @content.css(".description").css("p").text
  end

  def get_effects
    dataset = @content.css(".m-histogram")
    effects = dataset[0].css(".m-attr-label").css(".copexity--sm").children.map { |effect| effect.text }
    #effect_amt = dataset[0].css(".m-attr-bar")[1]["style"].gsub(/\D/, "").slice(0..1)
  end

  def get_medical
    dataset = @content.css(".m-histogram")
    effects = dataset[1].css(".m-attr-label").css(".copy--sm").children.map { |effect| effect.text }
  end

  def get_negatives
    dataset = @content.css(".m-histogram")
    effects = dataset[2].css(".m-attr-label").css(".copy--sm").children.map { |effect| effect.text }
  end

end
