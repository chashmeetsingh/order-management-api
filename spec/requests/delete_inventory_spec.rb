require 'rails_helper'
describe "delete an inventory item", :type => :request do
  before(:each) do
    @inventory = FactoryBot.create_list(:random_inventory, 1)[0]
  end
  before do
    delete '/inventories/' + @inventory.id.to_s
  end

  it 'returns the deletion status' do
    expect(JSON.parse(response.body)['message']).to eq('Item successfully deleted')
  end
  it 'returns status code 200' do
    expect(response).to have_http_status(:ok)
  end
end

describe "try delete a non existing inventory item", :type => :request do
  before(:each) do
    @inventory = FactoryBot.create_list(:random_inventory, 1)[0]
  end
  before do
    delete '/inventories/' + (@inventory.id + 1).to_s
  end

  it 'returns the deletion status' do
    expect(JSON.parse(response.body)['message']).to eq('Item could not be found')
  end
  it 'returns status code 404' do
    expect(response).to have_http_status(:not_found)
  end
end