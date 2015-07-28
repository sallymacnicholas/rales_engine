class Api::V1::InvoicesController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with Invoice.all
  end

  def show
    respond_with Invoice.find_by(id: params[:id])
  end

  def create
    respond_with Invoice.create(merchant_params)
  end

  def update
    respond_with Invoice.create(params[:id], invoice_params)
  end

  def destroy
    respond_with Invoice.destroy(params[:id])
  end

  def random
    respond_with Invoice.limit(1).order("RANDOM()")
  end

  def find
    render json: Invoice.find_by(find_params)
  end

  def find_all
    render json: Invoice.where(find_params)
  end

  def transactions
    render json: Invoice.find_by(id: params[:invoice_id]).transactions
  end

  def invoice_items
    render json: Invoice.find_by(id: params[:invoice_id]).invoice_items
  end

  def items
    render json: Invoice.find_by(id: params[:invoice_id]).items
  end

  def customer
    render json: Invoice.find_by(id: params[:invoice_id]).customer
  end

  def merchant
    render json: Invoice.find_by(id: params[:invoice_id]).merchant
  end

  private

  def invoice_params
    params.require(:invoice).permit(:customer_id, :merchant_id, :status, :created_at, :updated_at)
  end

  def find_params
    params.permit(:id, :customer_id, :merchant_id, :status, :created_at, :updated_at)
  end
end
