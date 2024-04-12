class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items
  has_one_attached :image

  validates :name, :description, :price, :category_id, :quantity, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "id_value", "name", "price", "quantity", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "order_items", "orders"]
  end
end
