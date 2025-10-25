document.addEventListener("turbo:load", () => {
  const likes = document.getElementById('likes')
  const DeleteLikes = document.getElementById('delete-likes')
  likes.addEventListener('click',function() {
    const ClickValue = likes.value;
    const likescounts = document.getElementById('likes-counts')
    likescounts.innerHTML = Math.floor(ClickValue + 1)

    likes.addEventListener('click',function(){
      likescounts.innerHTML = Math.floor(ClickValue - 1)
    })
  })
});