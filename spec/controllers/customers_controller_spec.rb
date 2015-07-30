require 'rails_helper'

describe Api::V1::CustomersController do
  context '#index' do
    it 'returns all the customers' do
      Customer.create(first_name: 'jorge', last_name: 'mexican')
      Customer.create(first_name: 'horace', last_name: 'hipster')

      get :index, format: :json

      expect(response).to have_http_status(:ok)
      customers = JSON.parse(response.body)
      expect(customers.count).to eq(2)

      customer = customers.first
      customer2 = customers.last
      expect(customer['first_name']).to eq('jorge')
      expect(customer['last_name']).to eq('mexican')
      expect(customer2['first_name']).to eq('horace')
      expect(customer2['last_name']).to eq('hipster')
    end
  end

  context '#show' do
    it 'returns a merchant' do
      customer = Customer.create(first_name: 'jorge', last_name: 'mexican')

      get :show, id: customer.id, format: :json

      expect(response).to have_http_status(:ok)
      customer = JSON.parse(response.body)

      expect(customer['first_name']).to eq('jorge')
      expect(customer['last_name']).to eq('mexican')
    end
  end

  context '#random' do
    it "returns a random customer" do
      Customer.create(first_name: 'jorge', last_name: 'mexican')
      get :random, format: :json

      expect(response).to have_http_status(:ok)
      customers = JSON.parse(response.body)
      expect(customers.first["first_name"]).to eq('jorge')
    end
  end

  context '#find' do
    it "can find by params" do
      Customer.create(first_name: 'jorge', last_name: 'mexican')
      get :find, name:'jorge', format: :json
      expect(response).to have_http_status(:ok)
      customer = JSON.parse(response.body)
      expect(customer["first_name"]).to eq('jorge')
    end

    it "can find all by params" do
      Customer.create(first_name: 'jorge', last_name: 'mexican')
      Customer.create(first_name: 'jorge', last_name: 'tellez')
      get :find_all, name:'jorge', format: :json
      expect(response).to have_http_status(:ok)
      customer = JSON.parse(response.body)
      expect(customer.first["last_name"]).to eq('mexican')
      expect(customer.last["last_name"]).to eq('tellez')
    end
  end

context 'invoices' do
  xit "can return invoices for a customer" do
    customer = Customer.create(first_name: 'jorge', last_name: 'mexican')
    merchant = Merchant.create(name: "Jalapenos", created_at: "2012-03-27 14:54:09", updated_at: "2012-03-27 14:54:09")
    invoice1 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped", created_at: "2020-12-12 12:12:12", updated_at: "2020-12-11 12:12:12")
    invoice2 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped", created_at: "2020-12-01 12:12:12", updated_at: "2020-12-11 12:12:12")

    get :invoices, id: customer.id, format: :json
    expect(response).to have_http_status(:ok)
    customer = JSON.parse(response.body)
    binding.pry
    expect(customer.first["last_name"]).to eq('mexican')
    expect(customer.last["last_name"]).to eq('tellez')
  end
end

  context 'invoices' do
    xit "can return invoices for a customer" do
      customer = Customer.create(first_name: 'jorge', last_name: 'mexican')
      merchant = Merchant.create(name: "Jalapenos", created_at: "2012-03-27 14:54:09", updated_at: "2012-03-27 14:54:09")
      invoice1 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped", created_at: "2020-12-12 12:12:12", updated_at: "2020-12-11 12:12:12")
      invoice2 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped", created_at: "2020-12-01 12:12:12", updated_at: "2020-12-11 12:12:12")

      get :merchants, id: customer.id, format: :json
      expect(response).to have_http_status(:ok)
      customer = JSON.parse(response.body)
      binding.pry
      expect(customer.first["last_name"]).to eq('mexican')
      expect(customer.last["last_name"]).to eq('tellez')
    end
  end
end
