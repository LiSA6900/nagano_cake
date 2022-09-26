class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      #注文ステータスが「入金確認」になったら製作ステータスを「製作待ち」に変更する
      if @order.order_status == "paid"
        @order.order_details.update_all(making_status: "waiting_production")
      end
      redirect_to admin_order_path(@order)
    else
      render :show
    end
  end


  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :postage, :price, :payment_method, :order_status)
  end

end
