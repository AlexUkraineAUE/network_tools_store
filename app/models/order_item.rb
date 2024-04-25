class OrderItem < ApplicationRecord
    belongs_to :order
    belongs_to :product

    validates :order_id, :product_id, :quantity, :subtotal, presence: true
    validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :subtotal, numericality: { greater_than_or_equal_to: 0 }

    def self.ransackable_attributes(auth_object = nil)
      ["created_at", "id", "id_value", "order_id", "product_id", "quantity", "subtotal", "updated_at"]
    end
end
