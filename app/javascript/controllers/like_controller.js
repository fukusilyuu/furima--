import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  

  static values = {
    liked: Boolean,
    likedCount: Number,
    commentLiked: Boolean,
    commentCount: Number,
    replyLiked: Boolean,
    replyCount: Number
  }

  static targets = ["likedCount"]

  update() {
    if (this.likedValue) {
      // すでにいいね済み → 減らす
      this.likedCountValue--
    } else {
      // まだいいねしてない → 増やす
      this.likedCountValue++
    }

    // 表示更新
    this.likedCountTarget.textContent = this.likedCountValue

    // 状態を反転
    this.likedValue = !this.likedValue
  }

  static replyTargets = ["replyCount"]

  update() {
    if (this.replyLikedValue) {
      // すでにいいね済み → 減らす
      this.replyCountValue--
    } else {
      // まだいいねしてない → 増やす
      this.replyCountValue++
    }

    // 表示更新
    this.replyCountTarget.textContent = this.replyCountValue

    // 状態を反転
    this.replyLikedValue = !this.replyLikedValue
    }
}