import { Controller } from "stimulus"

export default class extends Controller {
  mounted() {
    require("halfmoon").onDOMContentLoaded()
  }

  toggle() {
    require("halfmoon").toggleSidebar()
  }
}