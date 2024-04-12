class Customer < ApplicationRecord
  has_many :orders
  validates :first_name, :last_name, :email, :address, :city, :province, :postal_code, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.ransackable_associations(auth_object = nil)
    ["orders"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["address", "city", "created_at", "email", "first_name", "id", "id_value", "last_name", "phone_number", "postal_code", "province", "updated_at"]
  end
end
