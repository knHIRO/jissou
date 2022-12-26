class Order < ApplicationRecord
   belongs_to :customer
   has_many :order_details, dependent: :destroy
   enum payment_method: { credit_card: 0, transfer: 1 }
   enum payment_method: { awaiting: 0, confirmation: 1, manufacture: 2, preparing: 3, already: 4 }
end
