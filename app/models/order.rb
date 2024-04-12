class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items
  has_many :products, through: :order_items

  validates :customer_id, :total_price, presence: true
  validates :status, inclusion: { in: %w[pending completed] }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "customer_id", "id", "id_value", "order_date", "status", "total_price", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["customer", "order_items", "products"]
  end
end
