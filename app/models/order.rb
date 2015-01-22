class Order < ActiveRecord::Base
  validates :user_id, presence: true
  validates :items, presence: true
  has_many :line_items
  has_many :items, through: :line_items

  belongs_to :user
end
