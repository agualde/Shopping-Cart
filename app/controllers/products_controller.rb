class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    if params[:query].present?
      @order_item = current_order.order_items.new
      @products = Product.global_search(params[:query].downcase).paginate(page: params[:page], per_page: 9)
      respond_to do |format|
        format.html 
        format.text { render partial: 'products/index', locals: { products: @products, order_item: @order_item }, formats: [:html] }
      end
    else
      @products = Product.all.paginate(page: params[:page], per_page: 9)
    end
    @order_item = current_order.order_items.new
  end

  def show
    @product = Product.find(params[:id])
    @order_item = current_order.order_items.new
  end
end
