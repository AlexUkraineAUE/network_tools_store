class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Customer.page(params[:page]).per(20)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def permalink
    @customer = Customer.find_by(permalink: params[:permalink])
  end

  def new
    @customer = Customer.new
  end

  def edit
    @customer = Customer.find_by(permalink: params[:id])
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer, notice: 'Customer was successfully created.'
    else
      render :new
    end
  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: 'Customer was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_url, notice: 'Customer was successfully destroyed.'
  end

  private
    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :email, :address, :city, :province, :postal_code)
    end

end
