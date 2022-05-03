class PaymentsController < ApplicationController
  def new
    @order = current_user.checkouts.where(state: 'pending').find(params[:checkout_id])

    @items = Order.find(@order.orders_id).order_items
  end
end
