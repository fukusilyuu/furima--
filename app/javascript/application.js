// app/javascript/application.js
import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"

// 必要なら使う（なくても良い）
// import { definitionsFromContext } from "@hotwired/stimulus-loading"

const application = Application.start()

// 各コントローラを個別に import して登録する（相対パスは app/javascript からのパス）
import ClickViewsController from "./controllers/clickviews_controller.js"
import HelloController from "./controllers/hello_controller.js"
import PriceController from "./controllers/price_controller.js"
import SearchController from "./controllers/search_controller.js"
import TenController from "./controllers/ten_controller.js"
//import LikeController from "./controllers/like_controller.js"
//import CardController from "./controllers/card_controller.js"
// ...必要な分だけ import

application.register("clickviews", ClickViewsController)
application.register("hello", HelloController)
application.register("price", PriceController)
application.register("search", SearchController)
application.register("ten", TenController)
//application.register("like", LikeController)
//application.register("card", CardController)
