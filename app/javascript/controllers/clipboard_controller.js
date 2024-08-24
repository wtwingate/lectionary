import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = [
    "copyIcon"
  ]

  connect() {
  }

  copy(event) {
    // prevent the default action of the trigger element
    event.preventDefault();

    // copy the content from the sourceTarget to the clipboard
    navigator.clipboard.writeText(textPassages);

    // show the copied indicator
    this.copyIconTarget.classList.remove("fa-regular", "fa-copy");
    this.copyIconTarget.classList.add("fa-solid", "fa-check");

    // hide the copied indicator after 2 seconds
    setTimeout(() => {
      this.copyIconTarget.classList.remove("fa-solid", "fa-check");
      this.copyIconTarget.classList.add("fa-regular", "fa-copy");
    }, 2000)
  }
}
