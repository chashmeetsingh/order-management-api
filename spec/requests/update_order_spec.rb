require 'rails_helper'
describe "update an order", :type => :request do
  before(:each) do
    @inventory = FactoryBot.create_list(:random_inventory, 1)[0]
    @order = Order.new(email: 'test@test.com')
    @order.order_items << OrderItem.new(inventory_id: @inventory.id, quantity: 4)
    @order.save
  end
  before(:each) do
    @new_email = 'newtest@test.com'
    @new_quantity = 3
  end
  before do
    put '/orders/' + @inventory.id.to_s, params: {
        orders: {
            email: @new_email,
            order_items: [
                {
                    inventory_id: @inventory.id,
                    quantity: @new_quantity
                }
            ]
        }
    }
  end

  it 'returns the update order email' do
    expect(JSON.parse(response.body)['item']['email']).to eq(@new_email)
  end
  it 'returns the updated order quantity' do
    expect(JSON.parse(response.body)['item']['order_items'][0]['quantity']).to eq(@new_quantity)
  end
  it 'returns status code 202' do
    expect(response).to have_http_status(:accepted)
  end
end

describe "try update a non existing order", :type => :request do
  before(:each) do
    @inventory = FactoryBot.create_list(:random_inventory, 1)[0]
    @order = Order.new(email: 'test@test.com')
    @order.order_items << OrderItem.new(inventory_id: @inventory.id, quantity: 4)
    @order.save
  end
  before do
    put '/orders/' + (@order.id + 1).to_s
  end

  it 'returns the updation status' do
    expect(JSON.parse(response.body)['message']).to eq('Order could not be found')
  end
  it 'returns status code 404' do
    expect(response).to have_http_status(:not_found)
  end
end