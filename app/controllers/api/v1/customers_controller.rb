class Api::V1::CustomersController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find_by(id: params[:id])
  end

  def create
    respond_with Customer.create(merchant_params)
  end

  def update
    respond_with Customer.create(params[:id], customer_params)
  end

  def destroy
    respond_with Customer.destroy(params[:id])
  end

  def random
    respond_with Customer.limit(1).order("RANDOM()")
  end

  def find
    render json: Customer.find_by(find_params)
  end

  def find_all
    render json: Customer.where(find_params)
  end

  def invoices
    render json: Customer.find_by(id: params[:customer_id]).invoices
  end

  def transactions
    render json: Customer.find_by(id: params[:customer_id]).transactions
  end

  def favorite_merchant
    render json: Customer.find_by(id: params[:customer_id]).fave_merch
  end

  def merchants
    render json: Customer.find_by(id: params[:customer_id]).merchants
  end

  private

  def customer_params
    params.require(:merchant).permit(:first_name,:last_name, :created_at, :updated_at)
  end

  def find_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
