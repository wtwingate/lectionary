# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

# pin "@fortawesome/fontawesome-free", to: "@fortawesome--fontawesome-free.js" # @6.6.0
pin "@fortawesome/fontawesome-free", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.6.0/js/all.js"

pin_all_from "app/javascript/controllers", under: "controllers"
