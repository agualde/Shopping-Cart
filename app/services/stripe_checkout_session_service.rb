class StripeCheckoutSessionService
    def call(event)
      checkout = Checkout.find_by(checkout_session_id: event.data.object.id)
      checkout.update(state: 'paid')
    end
  end