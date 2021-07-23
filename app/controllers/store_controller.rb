class StoreController < ApplicationController
  def index
    @products = Product.order(created_at: :desc).limit(6)
  end

  def search
    @results = Product.all.where("lower(title) LIKE :search", search: "%#{params[:search]}%")
    if params[:search].present?
        render :partial => 'searchresults'
    else
        render :search
    end
  end

  # .order("price DESC")
  def all
    @pagy, @products = pagy(Product.all, items: 5)
  end

  def category
    @products = Product.where(category: params[:name])
  end

  def filter
    sortingParams = params[:sorting].present? ? params[:sorting] : "title"
    priceParams = params[:range].present? ? params[:range] : 10000000
    if params[:catArray].present?
      @pagy, @products = pagy(Product.with_sort(sortingParams).with_price(priceParams).with_category(params[:catArray]), items: 5)
    else 
      @pagy, @products = pagy(Product.with_sort(sortingParams).with_price(priceParams), items: 5)
    end
    render :partial => 'showproducts'
  end
end
