class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  validates :amount, presence: true

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end


  def subtotal #小計を求めるメソッド
    item.with_tax_price * amount
  end

end
