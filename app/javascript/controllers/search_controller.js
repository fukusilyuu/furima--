import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["keyword", "results"]

  // 入力イベント
  run(event) {
    console.log("run発火", event.target.value)

    const keywordEl = this.hasKeywordTarget ? this.keywordTarget : event.target
    if (!keywordEl) return

    const keyword = keywordEl.value.trim()

    if (keyword === "") {
      if (this.hasResultsTarget) this.resultsTarget.innerHTML = ""
      return
    }

    fetch(`/items/search?keyword=${encodeURIComponent(keyword)}`, {
      headers: { "Accept": "application/json" }
    })
      .then(response => {
        if (!response.ok) throw new Error("Network response was not ok")
        return response.json()
      })
      .then(names => {
        if (!this.hasResultsTarget) return

        // 候補 HTML 生成（クリック可能）
        const html = names.map(name => {
          return `<div class="search-item" data-action="click->search#select">${name}</div>`
        }).join("")

        this.resultsTarget.innerHTML = html
      })
      .catch(e => {
        console.error("search fetch error:", e)
      })
  }

  // 候補をクリック → input に反映 ＆ 一覧削除
  select(event) {
    const name = event.target.textContent

    // input にセット
    this.keywordTarget.value = name

    // 結果一覧をクリア
    if (this.hasResultsTarget) this.resultsTarget.innerHTML = ""
  }
}
