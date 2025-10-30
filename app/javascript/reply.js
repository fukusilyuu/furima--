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

  
});
