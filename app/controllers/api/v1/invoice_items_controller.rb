class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with InvoiceItem.find_by(id: params[:id])
  end

  def random
    respond_with InvoiceItem.limit(1).order("RANDOM()")
  end

  def find
    render json: InvoiceItem.find_by(find_params)
  end

  def find_all
    render json: InvoiceItem.where(find_params)
  end

  def invoice
    render json: find_invoice_item.invoice
  end

  def item
    render json: find_invoice_item.item
  end

  private

  def find_invoice_item
    InvoiceItem.find_by(id: params[:invoice_item_id])
  end

  def invoice_item_params
    params.require(:invoice_item).permit(:item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end

  def find_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end
