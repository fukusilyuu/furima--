const reply = () => {
  const Replies = document.getElementById("replies")
  if (!Replies) return;
  const Reply = document.getElementById("reply")
  Replies.addEventListener('click', function() {
    Reply.setAttribute("style", "display:block;");
    Replies.addEventListener('click', function() {
      Reply.setAttribute("style", "display:none;");
    });
  });
};
window.addEventListener("turbo:load", reply);
window.addEventListener("turbo:render", reply);