class Order < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :order_items

  validates :status, presence: true
  validates :total_price, numericality: { greater_than_or_equal_to: 1 }
  
  # Statuts possibles : pending, paid, cancelled
  enum status: { pending: 'pending', paid: 'paid', cancelled: 'cancelled' }

  # Une méthode pour vérifier si une commande est validée
  def validated?
    status == 'paid'
  end
end
