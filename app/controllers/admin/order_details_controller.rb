class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    if @order_detail.update(order_detail_params)
      @order = Order.find(params[:id])
      redirect_to admin_path
    else
      @order = Order.find(params[:id])
      @order_details = @order.order_details
      redirect_to admin_order_path(@order)
    end
  end


  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
