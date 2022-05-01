class PaymentsController < ApplicationController
  def new
    @order = current_user.checkouts.where(state: 'pending').find(params[:checkout_id])
  end
end
