document.addEventListener("turbo:load", () => {
  const tenran = document.getElementById("tenran");
  const tenshow = document.getElementById("tenshow");
  tenran.addEventListener('click', () => {
    if (tenshow.style.display === "none" || tenshow.classList.contains("hidden")) {
      tenshow.style.display = "block";
      tenshow.classList.remove("hidden");
    } else {
      tenshow.style.display = "none";
      tenshow.classList.add("hidden");
    }
  });
});