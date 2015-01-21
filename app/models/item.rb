class Item < ActiveRecord::Base
  validates :title, :description, :price, presence: true
  validates :title, uniqueness: true
  validates_numericality_of :price, greater_than: 0

  has_many :category_items
  has_many :categories, through: :category_items

end
