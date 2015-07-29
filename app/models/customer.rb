class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def fave_merch
    merchants.max_by { |m| m.invoices.successful.where(customer_id: id).count }
  end
end
