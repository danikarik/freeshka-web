import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form", "input"]

  connect() {
    this.inputTarget.addEventListener("keypress", this.handleEnterPressed())
  }

  disconnect() {
    this.inputTarget.removeEventListener("keypress", this.handleEnterPressed())
  }

  send() {
    this.formTarget.submit()
    this.inputTarget.value = ""
  }

  handleEnterPressed() {
    return e => {
      if (e.keyCode === 13) {
        this.send()
      }
    }
  }
}