class SiteContent < ApplicationRecord
  validates :name, presence: true

  def self.ransackable_attributes(*)
    ["content", "created_at", "id", "id_value", "name", "updated_at"]
  end

  def self.ransackable_associations(*)
    []
  end
end
