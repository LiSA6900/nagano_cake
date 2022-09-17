class Public::OrdersController < ApplicationController
  def new
    @order = Order.new(order_params)
  end

  def confirm
    @cart_items = CartItem.all
    @total = 0
    @cart_items.each do |cart|
      @total += cart.subtotal
    end
    @order = Order.find(params[:id])
    if session[:customer]["payment_method"] == "credit_card"
      @payment_method = "クレジットカード"
    else session[:customer]["payment_method"] == "transfer"
       @payment_method = "銀行振込"
    end
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to orders_confirm_path
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :postage, :price, :payment_method, :order_status)
  end
end
