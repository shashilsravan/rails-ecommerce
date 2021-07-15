class Product < ApplicationRecord
    scope :with_price, ->(price=10000000) { where("price < ?", price)}
    scope :with_category, ->(category) { where(category: category)}

    validates :title, presence: true, length: {maximum: 80}, 
        uniqueness: true
    validates :description, presence: true, length: {maximum: 500}
    validates :price, presence: true, numericality: { greater_than: 1}
    validates :category, presence: true, inclusion: {
        in: %w(mobiles accessories clothing sports others)
    }
    has_many :carts, dependent: :destroy
    has_one_attached :image
end
