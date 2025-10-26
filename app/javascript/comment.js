document.addEventListener("turbo:load", () => {
  const CommentRan = document.getElementById("comment-ran");
  if (!CommentRan) return;
 
  const comments = document.getElementById("comments");
  if (!comments) return;

  CommentRan.addEventListener("click", () => {
    // displayがnoneならblockに、それ以外ならnoneに切り替え
    if (comments.style.display === "none" || comments.classList.contains("hidden")) {
      comments.style.display = "block";
      comments.classList.remove("hidden");
    } else {
      comments.style.display = "none";
      comments.classList.add("hidden");
    }
  });
});