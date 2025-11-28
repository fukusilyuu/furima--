// ❌ Application を import してはいけない
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("search_controller connected!!");
  }
}
