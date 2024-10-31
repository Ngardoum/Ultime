class Menu < ApplicationRecord
  # Un menu appartient à un restaurant
  belongs_to :restaurant
  has_many :order_items
  has_one_attached :image

  # Validations
  validates :name, :description, :price, presence: true
end
