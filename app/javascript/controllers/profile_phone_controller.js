import { Controller } from "stimulus"
import Inputmask from "inputmask"
import profilePhonesChannel from "../channels/profile_phones_channel"

export default class extends Controller {
  static targets = ["input", "button"]

  initialize() {
    this.markAsInCompleted()

    this.done = false
    this.number = ""

    this.input = Inputmask("+7 (999) 999-99-99", {
      placeholder: "+7 (•••) •••-••-••",
      clearMaskOnLostFocus: false,
      onincomplete: () => {
        this.markAsInCompleted()
      },
      oncleared: () => {
        this.markAsInCompleted()
      },
      oncomplete: () => {
        this.markAsCompleted()
        this.saveNumber()
      },
    }).mask(this.inputTarget)
  }

  connect() {}

  disconnect() {}

  saveNumber() {
    this.number = this.formated()
  }

  formated() {
    let str = this.input.unmaskedvalue()
    if (str.length > 10) {
      if (str[0] === "7") {
        return str.slice(1, str.length)
      } else {
        this.markAsInCompleted()
      }
    } else {
      return str
    }
  }

  markAsInCompleted() {
    this.buttonTarget.disabled = true
    this.done = false
  }

  markAsCompleted() {
    this.buttonTarget.disabled = false
    this.done = true
  }

  clear() {
    this.inputTarget.value = ""
    this.markAsInCompleted()
  }

  isValid() {
    return this.number > 0 && this.done
  }

  add() {
    if (this.isValid()) {
      profilePhonesChannel.addPhone({ number: this.number })
    }
    this.clear()
  }
}
