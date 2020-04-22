import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["category"]

  initialize() {}

  connect() {
    if (this.hasCategoryTarget) {
      this.categoryTargets.map((category) => {
        this.setupMainCheckBoxHandler(category)
      })
    }
  }

  disconnect() {
    if (this.hasCategoryTarget) {
      this.categoryTargets.map((category) => {
        this.destroyMainCheckBoxHandler(category)
      })
    }
  }

  findMainCheckbox(target) {
    const nodes = target.getElementsByClassName("main-checkbox")
    if (nodes.length > 0) {
      return nodes[0]
    }
    return null
  }

  findChildCheckboxes(target) {
    const nodes = target.getElementsByClassName("child-checkbox")
    return nodes
  }

  setupMainCheckBoxHandler(target) {
    const mainCB = this.findMainCheckbox(target)
    if (mainCB !== null) {
      mainCB.addEventListener("change", this.handleMainCheckboxChange(target))
    }
  }

  destroyMainCheckBoxHandler(target) {
    const mainCB = this.findMainCheckbox(target)
    if (mainCB !== null) {
      mainCB.removeEventListener("change", this.handleMainCheckboxChange(target))
    }
  }

  handleMainCheckboxChange(target) {
    return (e) => {
      const childCBS = this.findChildCheckboxes(target)
      Array.from(childCBS).map((cb) => {
        cb.checked = e.target.checked
        cb.disabled = e.target.checked
      })
    }
  }
}
