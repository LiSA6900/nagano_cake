class Public::CartItemsController < ApplicationController

  def create
  end

  def index
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end

end
