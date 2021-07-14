class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
  end

  def search
    @results = Product.all.where("lower(title) LIKE :search", search: "%#{params[:search]}%")
    if params[:search].present?
        render :partial => 'searchresults'
    else
        render :search
    end
  end
end
