import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["entries", "pagination"]

  initialize() {
    const options = { rootMargin: "50px" }
    this.observer = new IntersectionObserver((entries) => this.scroll(entries), options)
  }

  connect() {
    this.observer.observe(this.paginationTarget)
  }

  disconnect() {
    this.observer.unobserve(this.paginationTarget)
  }

  scroll(entries) {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        this.loadMore()
      }
    })
  }

  loadMore() {
    const next = this.paginationTarget.querySelector("a[rel='next']")
    if (next === null) return

    Rails.ajax({
      type: "GET",
      url: next.href,
      dataType: "json",
      success: (data) => {
        this.entriesTarget.insertAdjacentHTML("beforeend", data.entries)
        this.paginationTarget.innerHTML = data.pagination
      },
    })
  }
}
