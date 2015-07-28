class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def most_revenue(x)

  end

  def revenue
    invoice_items.reduce(0) do |sum, inv_item|
      sum + ((inv_item.unit_price / 100.00) * inv_item.quantity)
    end
  end
end
