class Cart < ApplicationRecord
  belongs_to :customer
  belongs_to :product

  validates :customer_id, :product_id, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def total_price
    product.price * quantity
  end
end
