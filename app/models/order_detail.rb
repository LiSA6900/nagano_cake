class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum making_status: { cannot_start: 0, waiting_production: 1, production: 2, completion: 3 }
end
