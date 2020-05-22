import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["entries", "pagination"]

  initialize() {
    this.loading = false
  }

  scroll() {
    const next = this.paginationTarget.querySelector("a[rel='next']")
    if (next === null) {
      return
    }

    const url = next.href
    const body = document.body
    const html = document.documentElement

    const height = Math.max(
      body.scrollHeight,
      body.offsetHeight,
      html.clientHeight,
      html.scrollHeight,
      html.offsetHeight
    )

    if (window.pageYOffset >= height - window.innerHeight) {
      this.loadMore(url)
    }
  }

  loadMore(url) {
    if (this.loading) return
    this.loading = true

    Rails.ajax({
      type: "GET",
      url: url,
      dataType: "json",
      success: (data) => {
        this.entriesTarget.insertAdjacentHTML("beforeend", data.entries)
        this.paginationTarget.innerHTML = data.pagination
        this.loading = false
      },
    })
  }
}
