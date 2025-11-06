const price = () => {
  const itemprice = document.getElementById("item-price");
  if (!itemprice) return;
  itemprice.addEventListener('input',function() {
    const inputvalue = itemprice.value;
    const addtaxprice = document.getElementById("add-tax-price");
    const profit = document.getElementById('profit');
    addtaxprice.innerHTML = Math.floor(inputvalue * 0.1);
    profit.innerHTML = inputvalue - addtaxprice.innerHTML;
  });

  const orderprice = document.getElementById('order-price');
  if (!orderprice) return;

  const forsellersonly  = document.getElementById('for-sellers-only');
  if (!forsellersonly) return;

  orderprice.addEventListener('click', function(){
  
  if (forsellersonly.style.display === "none" || forsellersonly.classList.contains("hidden")) {
    forsellersonly.style.display = "block";
    this.firstChild.classList.remove("hidden");
    const salescommission = document.getElementById8('sales-commission');
  const salesprofit = document.getElementById('sales-profit');

  salescommission.innerHTML = Math.floor(orderprice * 0.1);
  salesprofit.innerHTML = orderprice = salescommission.innerHTML;
  } else {
    forsellersonly.style.display = "none";
    forsellersonly.classList.add("hidden");
  }
  });
};
window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);