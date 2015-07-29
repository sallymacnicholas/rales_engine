class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def most_revenue(x)

  end

  def revenue(params)
    if params[:date]
      invoices.successful.where(invoices: {created_at: params[:date]}).joins(:invoice_items).sum('quantity * unit_price') / 100.00
    else
    invoices.successful.joins(:invoice_items).sum('quantity * unit_price') / 100.00
    end
  end

  def fave_customer
    customers.max_by { |c| c.invoices.successful.where(merchant_id: id).count }.to_a
  end

  def customers_with_pending_invoices
    a = invoices - invoices.successful
    a.map {|i| i.customer }
  end

  private

  def revenue_params
    params.permit(:date)
  end
end
