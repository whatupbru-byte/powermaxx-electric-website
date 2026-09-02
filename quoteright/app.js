const fields = ['materials','hours','rate','markup','tax'];
const money = n => n.toLocaleString('en-CA',{style:'currency',currency:'CAD'});
function calculate(){
  const materials = Math.max(0, Number(document.getElementById('materials').value)||0);
  const hours = Math.max(0, Number(document.getElementById('hours').value)||0);
  const rate = Math.max(0, Number(document.getElementById('rate').value)||0);
  const markupPct = Math.max(0, Number(document.getElementById('markup').value)||0)/100;
  const taxPct = Math.max(0, Number(document.getElementById('tax').value)||0)/100;
  const labour = hours*rate;
  const markup = (materials+labour)*markupPct;
  const subtotal = materials+labour+markup;
  const tax = subtotal*taxPct;
  const total = subtotal+tax;
  document.getElementById('mOut').textContent=money(materials);
  document.getElementById('lOut').textContent=money(labour);
  document.getElementById('mkOut').textContent=money(markup);
  document.getElementById('sOut').textContent=money(subtotal);
  document.getElementById('tOut').textContent=money(tax);
  document.getElementById('gOut').textContent=money(total);
}
fields.forEach(id=>document.getElementById(id).addEventListener('input',calculate));
calculate();