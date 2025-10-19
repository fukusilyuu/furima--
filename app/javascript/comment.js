document.addEventListener("turbo:load", () => {
  const CommentRan = document.getElementById("comment-ran");
  const Comments = document.getElementById("comments")
  CommentRan.addEventListener('click',function() {
    Comments.setAttribute("style", "display:block;");
    CommentRan.addEventListener('click', function() {
      Comments.setAttribute("style", "display:none;");
    })
  })
});