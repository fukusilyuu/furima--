# Pin npm packages by running ./bin/importmap

pin 'application'
pin '@hotwired/turbo', to: 'https://cdn.jsdelivr.net/npm/@hotwired/turbo@8.0.4/dist/turbo.es2017-esm.js', preload: true
pin '@hotwired/stimulus', to: 'https://cdn.jsdelivr.net/npm/@hotwired/stimulus@3.2.2/dist/stimulus.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'

# pin '@hotwired/turbo-rails', to: 'https://cdn.jsdelivr.net/npm/@hotwired/turbo-rails@8.0.4/app/javascript/turbo/index.js', preload: true

pin 'card', to: 'card.js'
pin 'comment', to: 'comment.js'
pin 'price', to: 'price.js'
pin 'reply', to: 'reply.js'
pin 'like', to: 'like.js'
pin 'ten', to: 'ten.js'
# pin 'report', to: 'report.js'
pin 'all' # @0.0.0
# pin '@hotwired/turbo-rails', to: '@hotwired--turbo-rails.js' # @8.0.18
# pin '@hotwired/turbo', to: '@hotwired--turbo.js' # @8.0.18
# pin '@rails/actioncable/src', to: '@rails--actioncable--src.js' # @8.0.300
# pin '@hotwired/stimulus', to: '@hotwired--stimulus.js' # @3.2.2
