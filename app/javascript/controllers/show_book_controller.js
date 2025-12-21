// app/javascript/controllers/show_book_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "expandButton", "collapseButton"]
  static values = { maxHeight: { type: Number, default: 100 } }

  connect() {
    // コンテンツの高さがmaxHeightを超えている場合、「続きを見る」ボタンを表示
    if (this.contentTarget.scrollHeight > this.maxHeightValue) {
      this.contentTarget.style.maxHeight = this.maxHeightValue + "px"
      this.contentTarget.style.overflow = "hidden"
      this.expandButtonTarget.style.display = "inline"
    }
  }

  expandContent() {
    this.contentTarget.style.maxHeight = "none"
    this.contentTarget.style.overflow = "visible"
    this.expandButtonTarget.style.display = "none"
    this.collapseButtonTarget.style.display = "inline"
  }

  collapseContent() {
    this.contentTarget.style.maxHeight = this.maxHeightValue + "px"
    this.contentTarget.style.overflow = "hidden"
    this.expandButtonTarget.style.display = "inline"
    this.collapseButtonTarget.style.display = "none"
  }
}
