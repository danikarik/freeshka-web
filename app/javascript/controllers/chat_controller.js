import { Controller } from "stimulus"
import roomChannel from "../channels/rooms_channel"
import dataChannel from "../channels/room_data_channel"

export default class extends Controller {
  static targets = ["form", "input", "container", "message"]

  initialize() {
    if (this.hasContainerTarget) {
      this.containerTarget.scrollTop = this.containerTarget.scrollHeight
    }

    if (this.hasMessageTarget) {
      this.alignSelfMessages()
    }

    this.observer = new MutationObserver(this.newObserver())
  }

  connect() {
    document.addEventListener("click", this.handleActivityResume())
    this.inputTarget.addEventListener("keypress", this.handleEnterPressed())
    this.containerTarget.addEventListener("scroll", this.handleTopScroll())
    this.observer.observe(this.containerTarget, this.config)
  }

  disconnect() {
    document.removeEventListener("click", this.handleActivityResume())
    this.inputTarget.removeEventListener("keypress", this.handleEnterPressed())
    this.containerTarget.removeEventListener("scroll", this.handleTopScroll())
    this.observer.disconnect()
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

  newObserver() {
    return (mutationsList, observer) => {
      for (let mutation of mutationsList) {
        if (mutation.type === "childList") {
          this.alignSelfMessages()
        }
      }
    }
  }

  alignSelfMessages() {
    this.messageTargets.map((message) => {
      if (this.user == message.getAttribute("data-user")) {
        message.classList.add("self-end", "bg-green-100")
      }
    })
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
    if (this.data.get("next").toLowerCase() === "true") {
      return true
    }
    return false
  }

  get user() {
    return parseInt(this.data.get("user"))
  }

  get config() {
    return { childList: true }
  }
}
