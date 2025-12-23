import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "expandButton", "collapseButton"]
  static values = { maxHeight: { type: Number, default: 100 } }

  connect() {
    if (this.contentTarget.scrollHeight > this.maxHeightValue) {
      this.collapseContent()
    }
  }

  collapseContent() {
    this.contentTarget.classList.add("is-collapsed")
    this.expandButtonTarget.classList.add("is-displayed")
  }

  expand() {
    this.contentTarget.classList.remove("is-collapsed")
    this.expandButtonTarget.classList.remove("is-displayed")
    this.collapseButtonTarget.classList.add("is-displayed")
  }

  collapse() {
    this.contentTarget.classList.add("is-collapsed")
    this.expandButtonTarget.classList.add("is-displayed")
    this.collapseButtonTarget.classList.remove("is-displayed")
  }
}

