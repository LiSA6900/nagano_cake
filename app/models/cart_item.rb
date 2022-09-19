class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  def subtotal　#小計を求めるメソッド
    item.with_tax_price * amount
  end

end
