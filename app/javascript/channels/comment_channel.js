import consumer from "channels/consumer"

if(location.pathname.match(/\/items\/\d/)){

  // 以下を追加
    consumer.subscriptions.create({
      channel: "CommentChannel",
      item_id: location.pathname.match(/\d+/)[0]
    }, {
  
  // 以下を削除
  
      connected() {
        // Called when the subscription is ready for use on the server
      },
  
      disconnected() {
        // Called when the subscription has been terminated by the server
      },
  
      received(data) {
      }
    })
  }