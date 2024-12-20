import Lightbox from "@stimulus-components/lightbox"

export default class extends Lightbox {
  connect() {
    super.connect()
    this.lightGallery
    this.defaultOptions
  }

  get defaultOptions() {
    return {
      selector: '[data-lightbox="product-gallery"]',
    }
  }
}