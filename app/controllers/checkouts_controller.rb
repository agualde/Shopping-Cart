class CheckoutsController < ApplicationController
  def index
    @orders = current_user.checkouts
  end

  def show
    @order = current_user.checkouts.last
  end
  
  def create
    order = current_order
    amount_cents = (order.subtotal * 100)
    checkout  = Checkout.create!(amount: order.subtotal, state: 'pending', user: current_user, orders_id: order.id)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: 'Test',
        images: [],
        amount: amount_cents.to_i,
        currency: 'eur',
        quantity: 1
        }],
        success_url: checkout_url(checkout),
        cancel_url: checkout_url(checkout)
      )
      
      checkout.update(checkout_session_id: session.id)
      redirect_to new_checkout_payments_path(checkout, checkout_id: checkout)
  end
end
