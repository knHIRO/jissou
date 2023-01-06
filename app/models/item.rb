class Item < ApplicationRecord

  has_one_attached :profile_image
  has_many :cart_items, dependent: :destroy
  belongs_to :genre
  has_many :order_details, dependent: :destroy
  #enum is_active: { sale: 0, standstill: 1 }

  def get_profile_image(width,height)
     unless profile_image.attached?
       file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
       profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
     end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  def with_tax_price
    (price * 1.1).floor
  end

#   def with_tax_price
#     (price * 1.1).floor
#   end
end
