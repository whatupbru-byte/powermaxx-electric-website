(function () {
  const header = document.querySelector("[data-header]");
  const form = document.querySelector("[data-quote-form]");
  const note = document.querySelector("[data-form-note]");
  function updateHeader() { header.classList.toggle("is-scrolled", window.scrollY > 18); }
  updateHeader();
  window.addEventListener("scroll", updateHeader, { passive: true });
  if (form) {
    form.addEventListener("submit", function (event) {
      event.preventDefault();
      const data = new FormData(form);
      const name = String(data.get("name") || "").trim();
      const contact = String(data.get("contact") || "").trim();
      const type = String(data.get("type") || "").trim();
      const message = String(data.get("message") || "").trim();
      const subject = encodeURIComponent("Quote request from " + name);
      const body = encodeURIComponent("Name: " + name + "\n" + "Contact: " + contact + "\n" + "Project type: " + type + "\n\n" + "Project details:\n" + message);
      window.location.href = "mailto:powermaxxelectric@gmail.com?subject=" + subject + "&body=" + body;
      if (note) note.textContent = "Your email app should open with the quote request ready to send.";
    });
  }
})();
