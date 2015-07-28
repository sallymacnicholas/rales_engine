class Api::V1::ItemsController < ApplicationController
  respond_to :json, :xml

  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find_by(id: params[:id])
  end

  def create
    respond_with Item.create(item_params)
  end

  def update
    respond_with Item.create(params[:id], item_params)
  end

  def destroy
    respond_with Item.destroy(params[:id])
  end

  def random
    respond_with Item.limit(1).order("RANDOM()")
  end

  def find
    render json: Item.find_by(find_params)
  end

  def find_all
    render json: Item.where(find_params)
  end

  def invoice_items
    render json: find_item.invoice_items
  end

  def merchant
    render json: find_item.merchant
  end

  private
  def find_item
    Item.find_by(id: params[:item_id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end

  def find_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
