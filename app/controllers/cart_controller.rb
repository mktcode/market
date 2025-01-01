class CartController < ApplicationController
  def index
    @products = Current.user.favorite_products
  end

  def clear
    Current.user.favorites.destroy_all

    redirect_to cart_path, notice: "Deine Merkliste wurde geleert."
  end
end
