import { Controller } from "stimulus"

export default class extends Controller {
  toggle() {
    require("halfmoon").toggleSidebar()
  }
}
