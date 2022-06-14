// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
import { csrfToken } from '@rails/ujs'

export default class extends Controller {
  static targets = [ "timer", "bill" ]

  connect() {
    console.log('Stimulus fetch time initiated!');
    var seconds = 0;
    var end;
    var start = 0;
    var myThis = this;
    var participants = 0
    var myInterval;
    var isTimerRunning = false;

    callFrame
    .on('joined-meeting', (event) => {
      console.log('Participants: ' + ++participants);
      if (participants === 2 && !isTimerRunning) startTimer();
    })
    .on('participant-joined', (event) => {
      console.log('Participants: ' + ++participants);
      if (participants === 2 && !isTimerRunning) startTimer();
    })
    .on('left-meeting', (event) => {
      console.log('Participants: ' + --participants);
      if (participants != 2 && isTimerRunning) stopTimer();
    })
    .on('participant-left', (event) => {
      console.log('Participants: ' + --participants);
      if (participants != 2 && isTimerRunning) stopTimer();
    });

    // STATUSES = ['calling', 'online', 'finished', "cancelled"]
    function startTimer() {
      isTimerRunning = true;
      console.log('timer is on');
      if (start === 0) start = new Date();
      fetch(window.location.href, {
        method: 'PATCH',
        headers: {'Content-Type': 'application/json', "X-CSRF-Token": csrfToken()},
        body: JSON.stringify({'status': 'online', 'start_time': start})
        });

      myInterval = setInterval(() => {
          end = new Date();
          seconds = Math.round((end - start)/1000);
          myThis.timerTarget.textContent = `${Math.round(seconds / 60).toString().padStart(2, '0')}:${Math.round(seconds % 60).toString().padStart(2, '0')}`;
          myThis.billTarget.textContent = Math.round((end - start)/10 * 2 / 60)/100;
      }, 1000);
    }

    function stopTimer() {
      isTimerRunning = false;
      console.log('timer is off');
      fetch(window.location.href, {
        method: 'PATCH',
        headers: {'Content-Type': 'application/json', "X-CSRF-Token": csrfToken()},
        body: JSON.stringify({'status': 'finished', 'end_time': end})
        });
      clearInterval(myInterval);
    }

  }
}
