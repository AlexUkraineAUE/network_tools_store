class Customer < ApplicationRecord
  has_many :orders
  validates :first_name, :last_name, :email, :address, :city, :province, :postal_code, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :postal_code, length: { is: 6 }
end
