import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["input", "results"]

  resetOnClickOutside(e) {
    if (e.target !== this.inputTarget) {
      this.clear()
    }
  }

  resetOnEscape(e) {
    if (e.keyCode === 27) {
      this.clear()
    }
  }

  attemptSearch() {
    const val = this.inputTarget.value
    if (val) {
      const url = new URL(this.url)
      url.searchParams.append("q", val)

      fetch(url)
        .then((data) => data.text())
        .then((html) => {
          this.resultsTarget.innerHTML = html
        })
    } else {
      this.clear()
    }
  }

  clear() {
    this.inputTarget.value = ""
    this.resultsTarget.innerHTML = ""
  }

  get url() {
    return this.data.get("url")
  }
}
