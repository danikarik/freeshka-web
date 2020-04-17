import { Controller } from "stimulus"
import roomChannel from "../channels/rooms_channel"
import dataChannel from "../channels/room_data_channel"

export default class extends Controller {
  static targets = ["form", "input", "container", "message"]

  initialize() {
    if (this.hasContainerTarget) {
      this.containerTarget.scrollTop = this.containerTarget.scrollHeight
    }
  }

  connect() {
    document.addEventListener("click", this.handleActivityResume())
    this.inputTarget.addEventListener("keypress", this.handleEnterPressed())
    this.containerTarget.addEventListener("scroll", this.handleTopScroll())
  }

  disconnect() {
    document.removeEventListener("click", this.handleActivityResume())
    this.inputTarget.removeEventListener("keypress", this.handleEnterPressed())
    this.containerTarget.removeEventListener("scroll", this.handleTopScroll())
  }

  send() {
    roomChannel.sendMessage({
      room: this.room,
      body: this.inputTarget.value,
    })

    this.inputTarget.value = ""
  }

  update() {
    const divider = document.getElementById("unread")
    if (divider !== null) {
      roomChannel.sendLastRead({ room: this.room })
      divider.parentNode.removeChild(divider)
    }
  }

  request() {
    dataChannel.requestMessages({
      room: this.room,
      lastId: this.lastMessageId(),
    })
  }

  lastMessageId() {
    if (this.hasMessageTarget) {
      return this.messageTargets[0].getAttribute("data-id")
    }
    return 0
  }

  handleEnterPressed() {
    return (e) => {
      if (e.keyCode === 13) {
        e.preventDefault()
        if (this.inputTarget.value !== "") {
          this.send()
        }
      }
    }
  }

  handleActivityResume() {
    return (e) => {
      this.update()
    }
  }

  handleTopScroll() {
    return (e) => {
      if (this.containerTarget.scrollTop === 0 && this.next) {
        this.request()
      }
    }
  }

  get room() {
    return parseInt(this.data.get("room"))
  }

  get next() {
    const raw = this.data.get("next").toLowerCase()
    if (raw === "true") {
      return true
    }
    return false
  }
}
