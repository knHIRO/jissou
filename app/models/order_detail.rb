class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order
  enum making_status: { wrong: 0, awaiting: 1, manufacture: 2, production: 3 }
   def subtotal
    item.with_tax_price * amount
   end
end
