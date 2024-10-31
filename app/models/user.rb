class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# Ajout de l'association : Un utilisateur peut avoir plusieurs restaurants
  has_many :restaurants, dependent: :destroy
  has_many :orders
  has_many :messages

# Un utilisateur peut être soit un restaurant, soit un client dans une conversation
  
  has_many :sent_messages, as: :sender, class_name: 'Message'
  has_many :received_messages, foreign_key: 'receiver_id', class_name: 'Message'
  
  enum role: { client: 0, restaurant: 1 }

# Validation supplémentaire si nécessaire
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :role, presence: true     
end
