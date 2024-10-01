import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["template", "container"]

  add_association(event) {
    event.preventDefault()

    var content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    this.containerTarget.insertAdjacentHTML('beforeend', content)
  }

  remove_association(event) {
    event.preventDefault()

    if (confirm('Are you sure you want to delete this record?')) {
      let wrapper = event.target.closest("tr")
      if (wrapper.dataset.newRecord == "true") {
        wrapper.remove()
      } else {
        wrapper.querySelector("input[name*='_destroy']").value = 1
        wrapper.style.display = "none"
      }
    }
  }
}
