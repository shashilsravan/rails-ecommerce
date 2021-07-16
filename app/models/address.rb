class Address < ApplicationRecord
    belongs_to :user

    validates :user_id, presence: true
    validates :phone, presence: true, length: {minimum:10, maximum:13}
    validates :email, presence: true
    validates :zipcode, presence: true
    validates :location, presence: true, length: {minimum:30}

    def self.getUserAddress(id)
        address = Address.find_by(user_id: id)
        return {
            phone: address.phone,
            email: address.email,
            location: address.location,
            zipcode: address.zipcode
        }
    end
end
