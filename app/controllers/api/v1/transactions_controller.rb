class Api::V1::TransactionsController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with Transaction.all
  end

  def show
    respond_with Transaction.find_by(id: params[:id])
  end

  def random
    respond_with Transaction.limit(1).order("RANDOM()")
  end

  def find
    render json: Transaction.find_by(find_params)
  end

  def find_all
    render json: Transaction.where(find_params)
  end

  def invoice
    render json: Transaction.find_by(id: params[:transaction_id]).invoice
  end

  private

  def transaction_params
    params.require(:transaction).permit(:invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at)
  end

  def find_params
    params.permit(:id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at)
  end
end
