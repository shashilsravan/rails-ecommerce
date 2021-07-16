class Order < ApplicationRecord
    belongs_to :user

    serialize :order_data, Array
    serialize :deliver_address, Hash
end
