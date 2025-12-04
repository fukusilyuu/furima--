// app/javascript/controllers/index.js
import { application } from "./application"

// require.context を使って自動でコントローラを読み込む
const context = require.context(".", true, /\.js$/)

// 自分自身を除外して application.js で読み込む
context.keys().forEach((key) => {
  if (key === "./index.js") return
  const controller = context(key).default
  const name = key.replace("./", "").replace(".js", "")
  application.register(name, controller)
})
