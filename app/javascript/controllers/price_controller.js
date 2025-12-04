import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="price"
export default class extends Controller {
  static targets = ["input", "addtax", "profit"]

  connect() {
    // ページ読み込み時に実行
    if (!this.hasInputTarget) return

    this.inputTarget.addEventListener("input", () => {
      this.updatePrice()
    })
  }

  updatePrice() {
    const value = Number(this.inputTarget.value)

    // 10% の税
    this.addtaxTarget.innerHTML = Math.floor(value * 0.1)
    // 利益
    this.profitTarget.innerHTML = value - this.addtaxTarget.innerHTML
  }
}
