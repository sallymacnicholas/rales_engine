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
    render json: find_customer.invoices
  end

  def transactions
    render json: find_customer.transactions
  end

  def favorite_merchant
    render json: find_customer.fave_merch
  end

  def merchants
    render json: find_customer.merchants
  end

  private

  def find_customer
    Customer.find_by(id: params[:customer_id])
  end

  def customer_params
    params.require(:merchant).permit(:first_name,:last_name, :created_at, :updated_at)
  end

  def find_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
