import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "productId" ]

  connect() {
    console.log("Cart add connected");
  }

  addProduct() {
    const productId = this.productIdTarget.value;

    localStorage.setItem("cart", JSON.stringify([productId]));
    this.dispatch("productAdded")
    console.log("Product added", productId);
  }
}