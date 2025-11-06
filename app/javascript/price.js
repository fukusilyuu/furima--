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
  orderprice.addEventListener('', function(){
  const salescommission = document.getElementById8('sales-commission');
  const salesprofit = document.getElementById('sales-profit');

  salescommission.innerHTML = Math.floor(orderprice * 0.1);
  salesprofit.innerHTML = orderprice = salescommission.innerHTML;
  });
};
window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);