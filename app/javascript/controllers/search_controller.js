import { Controller } from "stimulus";
import { useDebounce } from "stimulus-use";

export default class extends Controller {
  static targets = ["form", "query", "output"];
  static debounces = ["update"];

  connect() {
    useDebounce(this);
  }

  update(event) {
    if (this.queryTarget.value != "") {
      let url = `${this.formTarget.action}?query=${this.queryTarget.value}`;
      fetch(url, { headers: { Accept: "text/plain" } })
        .then((response) => response.text())
        .then((data) => {
          this.outputTarget.innerHTML = data;
        });
    }
  }
}
