class AddressController < ApplicationController
    def create 
        user_id = current_user.id
        email = params[:email]
        phone = params[:phone]
        location = params[:location]
        zipcode = params[:zipcode]

        is_user = Address.find_by(user_id: current_user.id)
        if is_user.nil?
            Address.create(user_id: user_id, email: email, 
                phone: phone, location: location, zipcode: zipcode)
            redirect_to order_path
        else  
            addr = is_user
            addr.update(user_id: user_id, email: email, 
                phone: phone, location: location, zipcode: zipcode)
            redirect_to order_path
        end
    end
end