class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @cart_items = CartItem.all
    @total = 0
    @cart_items.each do |cart|
      @total += cart.subtotal
    end
    #支払方法の表示は不要
    # if params[:order]["payment_method"] == "1"
    #   @payment_method = "クレジットカード"
    # elsif params[:order]["payment_method"] == "2"
    #   @payment_method = "銀行振込"
    # end
    #お届け先の表示
    @order = Order.new(order_params)
    if params[:order][:address_display] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_display] == "1"
      @order.postal_code = Address.find(params[:order][:address_id]).postal_code
      @order.address = Address.find(params[:order][:address_id]).address
      @order.name = Address.find(params[:order][:address_id]).name
    elsif params[:order][:address_display] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address =  params[:order][:address]
      @order.name =  params[:order][:name]
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    # order_detailsに保存
    current_customer.cart_items.each do |cart_item| #カート内商品を1つずつ取り出しループ
      @order_detail = OrderDetail.new  #初期化宣言
      @order_detail.order_id = @order.id #order注文idを紐付けておく
      @order_detail.item_id = cart_item.item_id #カート内商品idを注文商品idに代入
      @order_detail.amount = cart_item.amount  #カート内商品の個数を注文商品の個数に代入
      @order_detail.price = cart_item.item.price.floor.to_s(:delimited)*1.1 #消費税込みに計算して代入
      @order_detail.save #注文商品を保存
    end
    current_customer.cart_items.destroy_all  #カートの中身を削除
    redirect_to orders_complete_path
  end

  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :postage, :price, :payment_method, :order_status)
  end
end
