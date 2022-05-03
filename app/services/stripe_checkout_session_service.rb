class StripeCheckoutSessionService
    def call(event)
      checkout = Checkout.find_by(checkout_session_id: event.data.object.id)
      session[:order_id] = nil
      checkout.update(state: 'paid')
    end
  end