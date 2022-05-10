class OrderItemsController < ApplicationController
    skip_before_action :authenticate_user!, only: [:create, :update, :destroy]
    def create 
        @order = current_order
        if @order.order_items.empty? && params[:product_id].nil?
            @order_item = @order.order_items.new(order_params)
            @order.save
            session[:order_id] = @order.id

        elsif @order.order_items.empty? && params[:product_id].present
            @order.save
            @order.order_items.new(product_id: params[:product_id], order: order, quantity: 1 )
            @order.save
            session[:order_id] = @order.id
        else
            find_in_cart
        end
    end

    def update 
        @order = current_order
        @order_item = @order.order_items.find(params[:id])
        @order_item.update(order_params)
        @order_items = current_order.order_items
    end

    def destroy 
        @order = current_order
        @order_item = @order.order_items.find(params[:id])
        @order_item.destroy
        @order_items = current_order.order_items
    end

    private

    def find_in_cart
        order_item = @order.order_items.where(product_id: params["order_item"]["product_id"].to_i)
        if order_item.present?
                update_quantity = order_item[0].quantity + params["order_item"]["quantity"].to_i 
                order_item.update(quantity: update_quantity)
             else    
                OrderItem.create(order_id: @order.id, product_id: params["order_item"]["product_id"].to_i, quantity: params["order_item"]["quantity"].to_i)
        end
    end

    def order_params
        params.require(:order_item).permit(:product_id, :quantity)
    end
end
