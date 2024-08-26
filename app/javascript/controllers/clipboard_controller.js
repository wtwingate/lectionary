import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = [
    "copyButton"
  ]

  connect() {
  }

  copy(event) {
    // prevent the default action of the trigger element
    event.preventDefault();

    // copy the content from the sourceTarget to the clipboard
    navigator.clipboard.writeText(copyText);

    // show the copied indicator
    this.copyButton.classList.remove("fa-regular", "fa-copy");
    this.copyButton.classList.add("fa-solid", "fa-check");

    // hide the copied indicator after 2 seconds
    setTimeout(() => {
      this.copyButton.classList.remove("fa-solid", "fa-check");
      this.copyButton.classList.add("fa-regular", "fa-copy");
    }, 2000)
  }
}
