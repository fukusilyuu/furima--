import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["on", "show", "tenreply", "showreply", "userten", "usershow"]
  
  on() {
    const show = this.showTarget

    // hidden クラスか display:none で判別
    if (show.style.display === "none" || show.classList.contains("hidden")) {
      show.style.display = "block"
      show.classList.remove("hidden")
    } else {
      show.style.display = "none"
      show.classList.add("hidden")
    }
  }

  tenreply() {
    const showreply = this.showreplyTarget

    // hidden クラスか display:none で判別
    if (showreply.style.display === "none" || showreply.classList.contains("hidden")) {
      showreply.style.display = "block"
      showreply.classList.remove("hidden")
    } else {
      showreply.style.display = "none"
      showreply.classList.add("hidden")
    }
  }

  userten() {
    const usershow = this.usershowTarget

    // hidden クラスか display:none で判別
    if (usershow.style.display === "none" || usershow.classList.contains("hidden")) {
      usershow.style.display = "block"
      usershow.classList.remove("hidden")
    } else {
      usershow.style.display = "none"
      usershow.classList.add("hidden")
    }
  }

  
}