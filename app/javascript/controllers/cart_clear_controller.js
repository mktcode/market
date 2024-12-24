import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Cart clear connected");
  }

  clear() {
    localStorage.setItem("cart", JSON.stringify([]));
    this.dispatch("cartCleared");
    console.log("Cart cleared");
  }
}