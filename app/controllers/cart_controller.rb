class CartController < ApplicationController
  allow_unauthenticated_access only: [ :index, :products ]

  def index
    @products = Product.where(published: true).order(created_at: :desc).limit(4)
  end

  def products
    if params[:ids].present?
      @products = Product.where(id: params[:ids].split(",").map(&:to_i), published: true)
    else
      @products = []
    end
  end
end
