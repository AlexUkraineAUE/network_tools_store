class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.page(params[:page]).per(12)
  end

  def show
    @product = Product.find(params[:id])
    session[:visit_count] ||= 0
    session[:visit_count] += 1
    @visit_count = session[:visit_count]
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"
    @products = Product.includes(:category).where("name LIKE ? OR description LIKE ?", wildcard_search, wildcard_search)
    if params[:category].present? && params[:category][:category_ids].present?
      @products = @products.where(category_id: params[:category][:category_ids])
    end
    @products = @products.where.not(discounted_price: nil) if params[:on_sale].present?

    # Filter products that are new (added to the site within the past 3 days)
    @products = @products.where("created_at >= ?", 3.days.ago) if params[:new_products].present?

    @products = @products.page(params[:page]).per(12)
  end

  def permalink
    @product = Product.find_by(permalink: params[:permalink])
  end

  def new
    @product = Product.new
  end

  def edit
    @products = Product.find_by(permalink: params[:id])
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :category_id)
    end
end
