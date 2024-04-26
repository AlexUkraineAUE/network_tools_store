class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]

  def index
    @orders = Order.page(params[:page]).per(20)
  end

  def show
    @order = Order.find(params[:id])
  end

  def permalink
    @order = Order.find_by(permalink: params[:permalink])
  end

  def new
    @order = Order.new
  end

  def edit
    @orders = Order.find_by(permalink: params[:id])
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to @order, notice: "Order was successfully created."
    else
      render :new
    end
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: "Order was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_url, notice: "Order was successfully destroyed."
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:customer_id, :total_price, :status)
  end
end
