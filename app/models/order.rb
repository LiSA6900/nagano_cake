class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment_method: { credit_card: 1, transfer: 2 }
  enum order_status: { notpay: 0, paid: 1, production: 2, shipping_preparation: 3, shipped: 4 }
end
