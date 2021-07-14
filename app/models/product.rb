class Product < ApplicationRecord
    validates :title, presence: true, length: {maximum: 80}, uniqueness: true
    validates :description, presence: true, length: {maximum: 500}
    validates :price, presence: true, numericality: { greater_than: 1}
    has_many :carts, dependent: :destroy
    has_one_attached :image
end
