class Product < ApplicationRecord
  validates_presence_of(:name, :cost)
  has_many :variants

  def self.to_json
    all.as_json(include: :variants).to_json
  end
end
