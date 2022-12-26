class Genre < ApplicationRecord
  has_many :items, dependent: :destroy

validates :name, uniqueness: { case_sensitive: false }, length: { minimum: 2, maximum: 20 }
end
