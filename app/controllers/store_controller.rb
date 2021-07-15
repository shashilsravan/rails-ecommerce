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

  def all
  end

  def category
    @products = Product.where(category: params[:name])
  end

  def filter
    if params[:catArray].present? and params[:range].present?
      @products = Product.with_price(params[:range]).with_category(params[:catArray])
    elsif params[:catArray].present?
      @products = Product.with_price.with_category(params[:catArray])
    elsif params[:range].present?
      @products = Product.with_price(params[:range])
    else
      @products = Product.all
    end
    render :partial => 'showproducts'
  end
end
