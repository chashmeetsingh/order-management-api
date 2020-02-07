require 'rails_helper'
describe "update an inventory item", :type => :request do
  before(:each) do
    @inventory = FactoryBot.create_list(:random_inventory, 1)[0]
  end
  before(:each) do
    @new_name = Faker::Appliance.equipment
    @new_description = Faker::Lorem.sentence
    @new_quantity = Faker::Number.number(digits: 10)
    @new_price = Faker::Number.decimal(l_digits: 2)
  end
  before do
    put '/inventories/' + @inventory.id.to_s, params: {
        inventory: {
            name: @new_name,
            description: @new_description,
            quantity: @new_quantity,
            price: @new_price
        }
    }
  end

  it 'returns the updated inventory item\'s name' do
    expect(JSON.parse(response.body)['inventory']['name']).to eq(@new_name)
  end
  it 'returns the updated item\'s description' do
    expect(JSON.parse(response.body)['inventory']['description']).to eq(@new_description)
  end
  it 'returns the updated item\'s price' do
    expect(JSON.parse(response.body)['inventory']['price']).to eq(@new_price)
  end
  it 'returns the updated item\'s quantity' do
    expect(JSON.parse(response.body)['inventory']['quantity']).to eq(@new_quantity)
  end
  it 'returns status code 202' do
    expect(response).to have_http_status(:accepted)
  end
end

describe "try update a non existing inventory item", :type => :request do
  before(:each) do
    @inventory = FactoryBot.create_list(:random_inventory, 1)[0]
  end
  before do
    put '/inventories/' + (@inventory.id + 1).to_s
  end

  it 'returns the updation status' do
    expect(JSON.parse(response.body)['message']).to eq('Item could not be found')
  end
  it 'returns status code 404' do
    expect(response).to have_http_status(:not_found)
  end
end