require 'rails_helper'
describe "get all inventories route", :type => :request do
  let!(:inventories) {FactoryBot.create_list(:random_inventory, 20)}
  before {get '/inventories'}
  it 'returns all inventory items' do
    expect(JSON.parse(response.body)['inventories'].size).to eq(20)
  end
  it 'returns status code 302' do
    expect(response).to have_http_status(:found)
  end
end

describe "get all inventories route", :type => :request do
  let!(:inventories) {FactoryBot.create_list(:random_inventory, 0)}
  before {get '/inventories'}
  it 'returns all inventory items' do
    expect(JSON.parse(response.body)['inventories'].size).to eq(0)
  end
  it 'returns status code 200' do
    expect(response).to have_http_status(:ok)
  end
end

describe "get one inventory route", :type => :request do
  before(:each) do
    @inventory = FactoryBot.create_list(:random_inventory, 1)[0]
  end
  before {get '/inventories/' + @inventory.id.to_s}
  it 'returns one inventory item' do
    expect(JSON.parse(response.body)['inventory'].size).to eq(5)
  end
  it 'returns status code 302' do
    expect(response).to have_http_status(:found)
  end
end