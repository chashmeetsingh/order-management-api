require 'rails_helper'
describe "post an order", :type => :request do
  before do
    @inventory = Inventory.create(:name => 'test_inventory', :description => 'test_description', :price => 10.52, :quantity => 20)
    post '/orders', params: {
        :orders => {
            :email => 'test@test.com',
            :order_items => [{
                inventory_id: @inventory.id,
                quantity: 5
            }]
        }
    }
  end
  it 'returns the order with order items' do
    expect(JSON.parse(response.body)['order_items'].size).to eq(1)
  end
  it 'returns the email used for order' do
    expect(JSON.parse(response.body)['email']).to eq('test@test.com')
  end
  it 'returns status code 201' do
    expect(response).to have_http_status(:created)
  end
end

describe "post an order with unavailable items", :type => :request do
  before do
    post '/orders', params: {
        :orders => {
            :email => 'test@test.com',
            :order_items => [{
              inventory_id: 1,
              quantity: 5
            }]
        }
    }
  end
  it 'return error stating order is invalid' do
    expect(JSON.parse(response.body)['errors']).to eq('Order items is invalid')
  end
  it 'returns status code 422' do
    expect(response).to have_http_status(:unprocessable_entity)
  end
end

describe "post an order with invalid email", :type => :request do
  before do
    @inventory = Inventory.create(:name => 'test_inventory', :description => 'test_description', :price => 10.52, :quantity => 20)
    post '/orders', params: {
        :orders => {
            :email => 'testtest.com',
            :order_items => [{
              inventory_id: @inventory.id,
              quantity: 5
            }]
        }
    }
  end
  it 'returns the order with invalid email error' do
    expect(JSON.parse(response.body)['errors']).to eq('Email is invalid')
  end
  it 'returns status code 422' do
    expect(response).to have_http_status(:unprocessable_entity)
  end
end