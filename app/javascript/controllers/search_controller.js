import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["keyword", "results"]

  run() {
    const keyword = this.keywordTarget.value.trim()

    fetch(`/items/search_names?keyword=${encodeURIComponent(keyword)}`, {
      headers: { "Accept": "text/vnd.turbo-stream.html" }
    })
      .then(r => r.text())
      .then(html => {
        this.resultsTarget.innerHTML = html
      })
  }
}
