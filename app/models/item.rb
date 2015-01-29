class Item < ActiveRecord::Base
  validates :title, :description, :price, presence: true
  validates :title, uniqueness: true
  validates :status, presence: true
  validates :categories, presence: true
  validates_numericality_of :price, greater_than: 0
  has_many :category_items
  has_many :categories, through: :category_items
  has_many :line_items
  has_many :orders, through: :line_items
  mount_uploader :image, ItemImageUploader

  default_scope { where(status: "show") }
  scope :hidden, -> { Item.unscoped { where(status: "hidden") } }

  attr_reader :quantity

  def add_quantity(quantity)
    @quantity = quantity
  end

  def currency
    price / 100
  end
end
