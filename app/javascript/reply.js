document.addEventListener("turbo:load", () => {
  const ReplyRan = document.getElementById("reply-ran");
  if (!ReplyRan) return;

  const ReplyShow = document.getElementById("reply-show");
  if (!ReplyShow) return;

  
  ReplyRan.addEventListener("click", () => {
    // displayがnoneならblockに、それ以外ならnoneに切り替え
    if (ReplyShow.style.display === "none" || ReplyShow.classList.contains("hidden")) {
      ReplyShow.style.display = "block";
      ReplyShow.classList.remove("hidden");
    } else {
      ReplyShow.style.display = "none";
      ReplyShow.classList.add("hidden");
    }
  });

  const Replies = document.getElementById("replies");
  const Reply = document.getElementById("reply");
  Replies.addEventListener('click', () => {
    if (Reply.style.display === "none" || Reply.classList.contains("hidden")) {
      Reply.style.display = "block";
      Reply.classList.remove("hidden");
    } else {
      Reply.style.display = "none";
      Reply.classList.add("hidden");
    }
  });
});
