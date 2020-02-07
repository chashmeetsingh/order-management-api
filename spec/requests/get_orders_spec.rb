require 'rails_helper'

describe "get all orders route", :type => :request do
  before(:each) do
    @inventory = FactoryBot.create_list(:random_inventory, 1)[0]
    @order = Order.new(email: 'test@test.com')
    @order.order_items << OrderItem.new(inventory_id: @inventory.id, quantity: 4)
    @order.save
  end

  before {get '/orders'}
  it 'returns all orders' do
    expect(JSON.parse(response.body).size).to eq(1)
  end
  it 'check order items for an order' do
    expect(JSON.parse(response.body)[0]['order_items'].size).to eq(1)
  end
  it 'returns status code 302' do
    expect(response).to have_http_status(:found)
  end
end

describe "get all inventories route", :type => :request do
  before {get '/orders'}
  it 'returns all inventory items' do
    expect(JSON.parse(response.body)['orders'].size).to eq(0)
  end
  it 'returns status code 200' do
    expect(response).to have_http_status(:ok)
  end
end

describe "get one inventory route", :type => :request do
  before(:each) do
    @inventory = FactoryBot.create_list(:random_inventory, 1)[0]
    @order = Order.new(email: 'test@test.com')
    @order.order_items << OrderItem.new(inventory_id: @inventory.id, quantity: 4)
    @order.save
  end
  before {get '/orders/' + @order.id.to_s}
  it 'check order items for an order' do
    expect(JSON.parse(response.body)['order_items'].size).to eq(1)
  end
  it 'returns status code 302' do
    expect(response).to have_http_status(:found)
  end
end
