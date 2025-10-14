
require_relative '../helpers'
require 'nokogiri'

RSpec.describe 'helpers' do
  describe '#get_node_value' do
    let(:xml) { Nokogiri::XML('<root><item><id>1</id><title>Title</title></item></root>') }
    let(:item) { xml.at_xpath('//item') }

    it 'returns the node value if the node exists' do
      expect(get_node_value(item, './id')).to eq('1')
    end

    it 'returns an empty string if the node does not exist' do
      expect(get_node_value(item, './description')).to eq('')
    end
  end
end
