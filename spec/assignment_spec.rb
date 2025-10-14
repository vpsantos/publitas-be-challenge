
require_relative '../assignment'

RSpec.describe App do
  let(:app) { App.new }

  describe '#parse_xml' do
    it 'correctly parses the XML file and populates the products array with the expected number of products' do
      app.parse_xml
      products = app.instance_variable_get(:@products)
      expect(products.size).to eq(50071)
    end
  end

  describe '#batch_products' do
        it 'batches the products into the correct number of batches, respecting the batch size, and sends them to the external service' do
      app.parse_xml
      external_service = app.instance_variable_get(:@external_service)
      expect(external_service).to receive(:call).at_least(:once)
      app.batch_products
      batched_products = app.instance_variable_get(:@batched_products)
      expect(batched_products.size).to eq(4)
      batch_size = app.instance_variable_get(:@batch_size)
      batched_products.each do |batch|
        expect(batch.size).to be <= batch_size
      end 
    end
  end
end
