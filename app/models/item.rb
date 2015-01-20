class Item < ActiveRecord::Base
  validates :title, :description, :price, presence: true
  validates :title, uniqueness: true

  has_many :category_items
  has_many :categories, through: :category_items

end
