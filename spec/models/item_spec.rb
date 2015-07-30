require 'rails_helper'

describe Item, type: :model do
  let(:customer) {Customer.create(first_name: "Jorge",
    last_name: "Mexican",
    created_at: "2020-12-12 12:12:12",
    updated_at: "2020-12-11 12:12:12")}

  let(:merchant) {Merchant.create(name: "Jalapenos",
    created_at: "2012-03-27 14:54:09",
    updated_at: "2012-03-27 14:54:09")}

  let(:invoice) {Invoice.create(customer_id: customer.id,
    merchant_id: merchant.id,
    status: "shipped",
    created_at: "2020-12-12 12:12:12",
    updated_at: "2020-12-11 12:12:12")}

  let(:item) {Item.create(name: "Tacos",
    description: "deliciosa",
    unit_price: 10,
    created_at: "2020-12-12 12:12:12",
    updated_at: "2020-12-11 12:12:12",
    merchant_id: merchant.id)
  }

  let(:invoice_item) {InvoiceItem.create item_id: item.id,
    invoice_id: invoice.id,
    quantity:10,
    unit_price: 100 }

  let(:transaction) { Transaction.create invoice_id: invoice.id,
    credit_card_number: "1010101010",
    result: "success"}

  let(:transaction2) { Transaction.create invoice_id: invoice.id,
    credit_card_number: "11111111111",
    result: "success"}

  before(:each) do
    customer
    merchant
    invoice
    item
    invoice_item
    transaction
    transaction2
  end

  it 'responds to invoice items' do
    expect(item).to respond_to(:invoice_items)
  end

  it 'responds to merchant' do
    expect(item).to respond_to(:merchant)
  end

  it 'should have many invoice items' do
    invoice_item
    expect(item.invoice_items.include?(invoice_item)).to be(true)
    expect(item.invoice_items.count).to eq(1)
  end

  it 'should belong to a merchant' do
    expect(item.merchant).to eq(merchant)
  end
end
