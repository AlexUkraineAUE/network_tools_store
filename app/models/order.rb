class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items
  has_many :products, through: :order_items

  validates :customer_id, :total_price, presence: true
  validates :status, inclusion: { in: %w[pending completed] }
end
