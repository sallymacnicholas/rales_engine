class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(params)
    successful_items.group(:name).sum('"invoice_items"."quantity" * "invoice_items"."unit_price"').sort_by(&:last).last(params[:quantity].to_i).reverse.map {|n, _| Item.find_by(name: n)}
  end

  def self.most_items(quantity)
    successful_items.group(:name).sum(:quantity).sort_by(&:last).last(quantity.to_i).map{|n, _| Item.find_by(name: n)}
  end

  def best_day
    invoices.successful.group('"invoices"."created_at"').sum("quantity * unit_price").sort_by(&:last).last.first
  end

  def self.successful_items
    joins(:invoices).merge(Invoice.successful)
  end
end
