if (!window.__appClientLoaded) {
  window.__appClientLoaded = true

  require('@hotwired/turbo')
}

require("@rails/ujs").start()
require("trix")
require("@rails/actiontext")
require("@rails/activestorage").start()

require("application")
