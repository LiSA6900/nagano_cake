class Order < ApplicationRecord
  enum payment_method: {credit_card: 1, transfar: 2 }
end
