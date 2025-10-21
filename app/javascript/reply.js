document.addEventListener("turbo:load", () => {
  const Replies = document.getElementById("replies");
  if (!Replies) return;

  const Reply = document.getElementById("reply");
  if (!Reply) return;

  
  Replies.addEventListener("click", () => {
    // displayがnoneならblockに、それ以外ならnoneに切り替え
    if (Reply.style.display === "none" || Reply.classList.contains("hidden")) {
      Reply.style.display = "block";
      Reply.classList.remove("hidden");
    } else {
      Reply.style.display = "none";
      Reply.classList.add("hidden");
    }
  });
});
