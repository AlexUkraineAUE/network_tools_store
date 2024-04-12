class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:show, :edit, :update, :destroy]

  def index
    @order_items = OrderItem.all
  end

  def show
    @order_item = OrderItem.find(params[:id])
  end

  def permalink
    @order_item = OrderItem.find_by(permalink: params[:permalink])
  end

  def new
    @order_item = OrderItem.new
  end

  def edit
    @order_item = OrderItem.find_by(permalink: params[:id])
  end

  def create
    @order_item = OrderItem.new(order_item_params)
    if @order_item.save
      redirect_to @order_item, notice: 'Order item was successfully created.'
    else
      render :new
    end
  end

  def update
    if @order_item.update(order_item_params)
      redirect_to @order_item, notice: 'Order item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @order_item.destroy
    redirect_to order_items_url, notice: 'Order item was successfully destroyed.'
  end

  private
    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    def order_item_params
      params.require(:order_item).permit(:order_id, :product_id, :quantity, :subtotal)
    end
end
