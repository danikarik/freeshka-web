import { Controller } from "stimulus"
import profilePhonesChannel from "../channels/profile_phones_channel"

export default class extends Controller {
  static targets = ["input"]

  initialize() {}

  connect() {}

  disconnect() {}

  add() {
    const number = this.inputTarget.value
    if (number.length > 0) {
      profilePhonesChannel.addPhone({ number: number })
      this.inputTarget.value = ""
    }
  }
}
