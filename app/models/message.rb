class Message < ApplicationRecord
 
  belongs_to :sender, polymorphic: true
  belongs_to :receiver, class_name: 'User'

  validates :content, presence: true
end
