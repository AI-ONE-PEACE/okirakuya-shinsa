import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"
window.bootstrap = bootstrap

document.addEventListener("turbo:load", () => {
  document.querySelectorAll('[data-bs-toggle="dropdown"]').forEach(el => {
    if (!bootstrap.Dropdown.getInstance(el)) new bootstrap.Dropdown(el)
  })
  document.querySelectorAll('[data-bs-toggle="collapse"]').forEach(el => {
    const target = document.querySelector(el.getAttribute("data-bs-target"))
    if (target && !bootstrap.Collapse.getInstance(target)) {
      new bootstrap.Collapse(target, { toggle: false })
    }
  })
})
