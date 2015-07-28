class Api::V1::MerchantsController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(id: params[:id])
  end

  def create
    respond_with Merchant.create(merchant_params)
  end

  def update
    respond_with Merchant.create(params[:id], merchant_params)
  end

  def destroy
    respond_with Merchant.destroy(params[:id])
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
    render json: Merchant.find_by(id: params[:merchant_id]).items
  end

  def invoices
    render json: Merchant.find_by(id: params[:merchant_id]).invoices
  end

  def revenue
    render json: Merchant.find_by(id: params[:merchant_id]).revenue
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name, :created_at, :updated_at)
  end

  def find_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
