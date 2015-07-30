require 'rails_helper'

describe Merchant, type: :model do
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

  let(:invoice2) {Invoice.create(customer_id: customer.id,
    merchant_id: merchant.id,
    status: "shipped",
    created_at: "2020-01-12 12:12:12",
    updated_at: "2020-01-11 12:12:12")}

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

  let(:invoice_item2) {InvoiceItem.create item_id: item.id,
    invoice_id: invoice2.id,
    quantity:10,
    unit_price: 100 }

  let(:transaction) { Transaction.create invoice_id: invoice.id,
                                         credit_card_number: "1010101010",
                                         result: "success"}

  let(:transaction2) { Transaction.create invoice_id: invoice.id,
    credit_card_number: "1010101010",
    result: "failed"}

  before(:each) do
   customer
   merchant
   invoice
   invoice2
   item
   invoice_item
   invoice_item2
   transaction
   transaction2
 end


  it 'should have many invoices' do
    expect(merchant.invoices.include?(invoice)).to be(true)
    expect(merchant.invoices.count).to eq(2)
  end

  it 'should have many items' do
    expect(merchant.items.include?(item)).to be(true)
    expect(merchant.items.count).to be(1)
  end

  it 'should return most revenue for x items' do
    params = {quantity: "1"}
    expect(Merchant.most_rev(params).first).to eq(merchant)
  end

  it 'returns customers with pending invoices' do
    expect(merchant.customers_with_pending_invoices.first).to eq(customer)
  end
end
