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
      this.counterTarget.classList.toggle("hidden", items.length === 0);
      this.counterTarget.classList.toggle("flex", items.length !== 0);
      console.log("Counter updated", items.length);
    }
  }
}