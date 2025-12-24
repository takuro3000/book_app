import { Controller } from "@hotwired/stimulus"

const HEIGHT_OF_FOUR_LINES = 100

export default class extends Controller {
  static targets = ["content", "expandButton", "collapseButton"]

  connect() {
    if (this.contentTarget.scrollHeight > HEIGHT_OF_FOUR_LINES) {
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

