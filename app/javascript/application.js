// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
Turbo.config.forms.confirm = function() {
      let dialog = document.getElementById('turbo-confirm')
      dialog.showModal();

      return new Promise((resolve) => {
            dialog.addEventListener("close", () => {
                  resolve(dialog.returnValue == 'confirm')
            }, { once: true })
      })
}

