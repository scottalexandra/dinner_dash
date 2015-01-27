class Order < ActiveRecord::Base
  validates :user_id, presence: true
  validates :items, presence: true
  has_many :line_items
  has_many :items, through: :line_items

  belongs_to :user

  def item_ids(order_items)
    item_ids = []
    order_items.each do |item|
      item_ids << item.id
    end
  end
end
