class Genre < ApplicationRecord

validates :name, uniqueness: { case_sensitive: false }, length: { minimum: 2, maximum: 20 }
end
