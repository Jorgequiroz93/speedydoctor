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
    console.log(window.callFrame);
    var seconds = 0;
    var end;
    var start;
    var myThis = this;

    function startChecker() {
      console.log(myThis);
      var joinChecker = setInterval(() => {
        console.log('Checker is on. Participants:' + window.callFrame._participantCounts.present);
        if (window.callFrame._participantCounts.present === 2) {
          start = new Date();
          clearInterval(joinChecker);
          console.log('Checker is OFF. Participants:' + window.callFrame._participantCounts.present);
          startTimer();
        }
      }, 100);
    }

    startChecker();

    function startTimer() {
      console.log('timer is on');
      var billing = setInterval(() => {
        console.log(window.callFrame._participantCounts.present);
        if (window.callFrame._participantCounts.present === 2) {
          end = new Date();
          seconds = Math.round((end - start)/1000);
          myThis.timerTarget.textContent = `${Math.round(seconds / 60).toString().padStart(2, '0')}:${Math.round(seconds % 60).toString().padStart(2, '0')}`;
          myThis.billTarget.textContent = Math.round((end - start)/10 * 2 / 60)/100;
        }
        else {
          console.log('timer is off');
          clearInterval(billing);
          startChecker();
        }
      }, 500);
    }

  }
}
