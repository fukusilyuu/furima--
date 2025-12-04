pin 'application'

# Turbo（Rails engine のファイルを使う）
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true

# Stimulus
pin '@hotwired/stimulus', to: 'https://cdn.jsdelivr.net/npm/@hotwired/stimulus/dist/stimulus.js'

# Stimulus controllers
pin_all_from 'app/javascript/controllers', under: 'controllers'

# あなたの JS ファイル
pin 'card', to: 'card.js'
pin 'comment', to: 'comment.js'
pin 'price', to: 'price.js'
pin 'reply', to: 'reply.js'
pin 'like', to: 'like.js'
pin 'ten', to: 'ten.js'
pin 'search', to: 'search.js'
