class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def fave_merch
   # merchants.max_by { |m| m.transactions.where(result: "success").count }
    hash = Hash.new(0)
    merchants.map { |m| hash[m] += 1 }
    hash.max.first
  end
end
