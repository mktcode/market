import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "counter" ]

  connect() {
    console.log("Cart counter connected");
    this.update();
  }

  update() {
    const savedCart = localStorage.getItem("cart");
    console.log("Updating counter", savedCart);
    if (savedCart) {
      const items = JSON.parse(savedCart);
      this.counterTarget.innerText = items.length;
      console.log("Counter updated", items.length);
    }
  }
}