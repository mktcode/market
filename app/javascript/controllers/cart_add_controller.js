import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "productId" ]

  connect() {
    console.log("Cart add connected");
  }

  addProduct() {
    const productId = this.productIdTarget.value;

    const savedCart = localStorage.getItem("cart");
    let items = savedCart ? JSON.parse(savedCart) : [];
    if (!items.includes(productId)) {
      items.push(productId);
      localStorage.setItem("cart", JSON.stringify(items));
    }

    this.dispatch("productAdded")
    console.log("Product added", productId);
  }
}