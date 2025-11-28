import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle", "body", "change", "reply"]  
  // toggle → comment-ran（クリックする要素）
  // body   → comments（表示/非表示を切り替える要素）


  toggle() {
    const body = this.bodyTarget

    // hidden クラスか display:none で判別
    if (body.style.display === "none" || body.classList.contains("hidden")) {
      body.style.display = "block"
      body.classList.remove("hidden")
    } else {
      body.style.display = "none"
      body.classList.add("hidden")
    }
  }

  change() {
    const reply = this.replyTarget

    // hidden クラスか display:none で判別
    if (reply.style.display === "none" || reply.classList.contains("hidden")) {
      reply.style.display = "block"
      reply.classList.remove("hidden")
    } else {
      reply.style.display = "none"
      reply.classList.add("hidden")
    }
  }
}
