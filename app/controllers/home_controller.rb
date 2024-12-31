class HomeController < ApplicationController
  allow_unauthenticated_access only: [ :index, :explore, :info ]

  def index
    @products = Product.where(published: true).order(created_at: :desc).limit(4)
  end

  def explore
    @products = Product.where(published: true)
  end

  def info
  end

  def imprint
  end
end
