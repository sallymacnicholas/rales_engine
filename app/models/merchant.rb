class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.most_rev(params)
    all.max_by(params[:quantity].to_i) { |m| m.calculate_revenue }
  end

  def revenue(params)
    if params[:date]
      revenue_for_date(params)
    else
      calculate_revenue
    end
  end

  def favorite_customer
    hash = Hash.new(0)
    customers.map { |c| hash[c] += 1 }
    max_value = hash.values.max
    hash.map { |k, v| k if v == max_value }.compact
  end

  def self.all_revenue(params)
    # Invoice.successful.where(invoices: {created_at: params[:date]}).joins(:invoice_items).sum("quantity * unit_price") / 100.00
    # Invoice.successful.where(invoices: {created_at: params[:date]}).joins(:invoice_items).sum('quantity * unit_price') /  100
    all.reduce(0) do |sum, m|
      sum + m.revenue_for_date(params)
    end
  end

  def calculate_revenue
    invoices.successful.joins(:invoice_items).sum("quantity * unit_price") / 100.00
  end

  def self.most_items(params)
    all.max_by(params[:quantity].to_i) { |m| m.total_items }
  end

  def total_items
    invoices.successful.joins(:invoice_items).sum(:quantity)
  end

  def revenue_for_date(params)
    invoices.successful.where(invoices: {created_at: params[:date]}).joins(:invoice_items).sum('quantity * unit_price') / 100.00
  end

  def customers_with_pending_invoices
    a = invoices - invoices.successful
    a.map {|i| i.customer }
  end

end
