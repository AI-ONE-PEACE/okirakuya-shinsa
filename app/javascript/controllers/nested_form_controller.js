import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container", "template"];

  add(e) {
    e.preventDefault();
    const html = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, Date.now().toString());
    this.containerTarget.insertAdjacentHTML("beforeend", html);
  }

  remove(e) {
    e.preventDefault();
    const wrapper = e.target.closest("[data-nested-form-wrapper]");
    if (!wrapper) return;

    // 既存レコードは _destroy に 1 を立てて非表示、新規行は DOM から削除
    const destroyField = wrapper.querySelector("input[name*='[_destroy]']");
    if (destroyField) {
      destroyField.value = "1";
      wrapper.style.display = "none";
    } else {
      wrapper.remove();
    }
  }
}
