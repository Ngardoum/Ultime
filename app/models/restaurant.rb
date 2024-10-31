class Restaurant < ApplicationRecord
  # Un restaurant appartient à un utilisateur (propriétaire)
  belongs_to :user
  has_many :orders

  has_many :menus, dependent: :destroy
  has_one_attached :logo
  
  def self.ransackable_associations(auth_object = nil)
    ["user", "menus", "orders", "logo_attachment", "logo_blob"]
  end

  # Validations
  validates :name, presence: true
  validates :address, presence: true
  validates :cuisine_type, presence: true
end
