class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true

  enum payment_method: { credit_card: 1, transfer: 2 }
  enum order_status: { notpay: 0, paid: 1, production: 2, shipping_preparation: 3, shipped: 4 }

  def postage
    800
  end

end
