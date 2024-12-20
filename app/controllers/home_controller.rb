class HomeController < ApplicationController
  allow_unauthenticated_access only: :index

  def index
    @products = Product.where(published: true)
  end
end
