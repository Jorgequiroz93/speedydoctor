// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "timer", "bill" ]

  connect() {
    console.log('Hello, Stimulus!');
    var start = new Date();
    setInterval(() => {
      var end = new Date();
      console.log((end - start)/1000);
      this.timerTarget.textContent = `${Math.round((end - start)/60000)}:${Math.round(((end - start)/1000) % 60)}`;
      this.billTarget.textContent = Math.round((end - start)/10 * 3)/100;
    }, 1000);
  }
}
