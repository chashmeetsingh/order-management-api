require 'rails_helper'
describe "post an inventory item", :type => :request do
  before do
    post '/inventories', params: { :inventory => { :name => 'test_inventory', :description => 'test_description', :price => 10.52, :quantity => 20 } }
  end
  it 'returns the inventory item\'s name' do
    expect(JSON.parse(response.body)['inventory']['name']).to eq('test_inventory')
  end
  it 'returns the item\'s description' do
    expect(JSON.parse(response.body)['inventory']['description']).to eq('test_description')
  end
  it 'returns the item\'s price' do
    expect(JSON.parse(response.body)['inventory']['price']).to eq(10.52)
  end
  it 'returns the item\'s quantity' do
    expect(JSON.parse(response.body)['inventory']['quantity']).to eq(20)
  end
  it 'returns status code 201' do
    expect(response).to have_http_status(:created)
  end
end

describe "post an inventory item with negative quantity and price", :type => :request do
  before do
    post '/inventories', params: { :inventory => { :name => 'test_inventory', :description => 'test_description', :price => -10.52, :quantity => -20 } }
  end
  it 'returns and error stating quantity and price to be greater than or equal to 0' do
    expect(JSON.parse(response.body)['errors']).to eq('Quantity must be greater than or equal to 0 and Price must be greater than or equal to 0')
  end
  it 'returns status code 422' do
    expect(response).to have_http_status(:unprocessable_entity)
  end
end