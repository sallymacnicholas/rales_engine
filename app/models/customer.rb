class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def fave_merch
    Merchants.order("count DESC").first
  end
end
