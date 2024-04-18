class Category < ApplicationRecord
  has_many :products
  has_one_attached :image

  validates :name, presence: true

  def self.ransackable_associations(auth_object = nil)
    ["products"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "updated_at"]
  end

end
