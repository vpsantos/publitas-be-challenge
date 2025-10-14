require 'nokogiri'
require 'json'
require_relative 'helpers'
require './services/ExternalService'

class App
  def initialize
    @xml_file = File.new('data/feed.xml')
    @xml_content = Nokogiri::XML(@xml_file)
    @external_service = ExternalService.new
    @batch_size = 14700
    @products = []
    @batched_products = []
  end

  def parse_xml
    @xml_content.xpath('//item').each do |item|
      product = {
        'id' => get_node_value(item, './g:id'),
        'title' => get_node_value(item, './title'),
        'description' => get_node_value(item, './description')
      }

      @products << product
    end
  end

  def batch_products
    if @products.size > 0
      @batched_products = @products.each_slice(@batch_size).to_a

      @batched_products.each do |batch|
        @external_service.call(batch.to_json)
      end
    end
  end
end

app = App.new
app.parse_xml
app.batch_products