class ProductsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    if params[:query].present?
      @products = Product.global_search(params[:query])
    else
      @products = Product.all
    end
    @order_item = current_order.order_items.new
  end

  def show
    @product = Product.find(params[:id])
  end
end
