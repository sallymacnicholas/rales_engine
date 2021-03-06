require 'rails_helper'

describe InvoiceItem, type: :model do
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

  it 'should have an invoice' do
    expect(invoice_item.invoice).to eq(invoice)
  end

  it 'should have an item' do
    expect(invoice_item.item).to eq(item)

  end
end
