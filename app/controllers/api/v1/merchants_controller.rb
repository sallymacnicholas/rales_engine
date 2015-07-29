class Api::V1::MerchantsController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(id: params[:id])
  end

  def random
    respond_with Merchant.limit(1).order("RANDOM()")
  end

  def find
    render json: Merchant.find_by(find_params)
  end

  def find_all
    render json: Merchant.where(find_params)
  end

  def items
    render json: find_merchant.items
  end

  def invoices
    render json: find_merchant.invoices
  end

  def revenue
    render json: find_merchant.revenue(params)
  end

  def favorite_customer
    render json: find_merchant.favorite_customer
  end

  def most_revenue
    respond_with Merchant.most_rev(params)
  end

  def all_revenue
    respond_with Merchant.all_revenue(params)
  end

  def most_items
    respond_with Merchant.most_items(params)
  end

  private

  def find_merchant
    Merchant.find_by(id: params[:merchant_id])
  end

  def merchant_params
    params.require(:merchant).permit(:name, :created_at, :updated_at)
  end

  def find_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
