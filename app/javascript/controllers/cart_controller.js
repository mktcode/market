import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "product" ]
  static cart = [];

  connect() {
    console.log("Cart connected");
    this.load();
  }

  load() {
    const savedCart = localStorage.getItem("cart");
    if (savedCart) {
      this.constructor.cart = JSON.parse(savedCart);
    }
    console.log("Cart loaded", this.constructor.cart);
  }

  addProduct() {
    const productId = this.productTarget.value;
    console.log("Product", productId);

    if (!this.constructor.cart.some((id) => id === productId)) {
      this.constructor.cart.push(productId);
      this.save();
    }
    console.log("Product added", this.constructor.cart);
  }

  save() {
    localStorage.setItem("cart", JSON.stringify(this.constructor.cart));
    console.log("Cart saved", this.constructor.cart);
  }

  clear() {
    this.constructor.cart = [];
    this.save();
    console.log("Cart cleared", this.constructor.cart);
  }
}