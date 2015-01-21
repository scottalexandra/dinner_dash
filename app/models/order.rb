class Order < ActiveRecord::Base
  validates :user_id, presence: true
  validates :items, presence: true
  has_many :order_items
  has_many :items, through: :order_items
end
