// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import { Application } from '@hotwired/stimulus'
import { Autocomplete } from 'stimulus-autocomplete'

const application = Application.start()
application.register('autocomplete', Autocomplete)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }