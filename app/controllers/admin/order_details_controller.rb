class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    if @order_detail.update(order_detail_params)
    #製作ステータスが1つでも「作成中」になったら注文ステータスを「製作中」に変更する
      if @order_detail.making_status == "production"
        @order.update(order_status: "production")
      end
    #全ての製作ステータスが「製作完了」になったら注文ステータスを「発送準備中」に変更する
      sum = 0
      @order.order_details.each do |order_detail|
        if order_detail.making_status == "completion"
          sum += 1
        end
      end
        if sum == @order.order_details.count
          @order.update(order_status: "shipping_preparation")
        end
      redirect_to admin_order_path(@order.id)
    else
      @order_details = @order.order_details
      redirect_to admin_order_path(@order.id)
    end
  end


  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end

