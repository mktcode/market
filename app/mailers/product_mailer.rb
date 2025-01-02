class ProductMailer < ApplicationMailer
  def new_product(follower, product)
    @follower = follower
    @product = product
    mail(
      to: @follower.email_address,
      subject: "Neues Produkt von #{product.user.name}"
    )
  end
end
