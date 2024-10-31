class Conversation < ApplicationRecord
  belongs_to :restaurant, class_name: 'User', foreign_key: 'restaurant_id'
  belongs_to :client, class_name: 'User', foreign_key: 'client_id'
  has_many :messages, dependent: :destroy
end
  
