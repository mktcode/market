class CartController < ApplicationController
  allow_unauthenticated_access only: [ :index ]

  def index
    @products = Product.where(published: true).order(created_at: :desc).limit(4)
  end
end
