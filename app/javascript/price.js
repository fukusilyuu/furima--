const price = () => {
  const itemprice = document.getElementById("item-price");
  if (!itemprice) return;
  itemprice.addEventListener('input',function() {
    console.log('w')
    const inputvalue = itemprice.value;
    const addtaxprice = document.getElementById("add-tax-price");
    const profit = document.getElementById('profit');
    addtaxprice.innerHTML = Math.floor(inputvalue * 3);
    profit.innerHTML = inputvalue - addtaxprice.innerHTML;
  });
};
window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);