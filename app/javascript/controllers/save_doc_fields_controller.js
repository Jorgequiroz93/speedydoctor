import { Controller } from "stimulus"
import { csrfToken } from '@rails/ujs'

export default class extends Controller {
  static targets = [ "doctorNotes", "advice", "prescription" ];

  connect() {
    console.log('Doctor saver stimulus connected!');
  }

  save() {
    console.log('saving ', this.doctorNotesTarget.value, this.adviceTarget.value, this.prescriptionTarget.value, ' via PATCH to: ', window.location.href )
    fetch(window.location.href, {
      method: 'PATCH',
      headers: {'Content-Type': 'application/json', "X-CSRF-Token": csrfToken()},
      body: JSON.stringify({
        'doctor_notes': this.doctorNotesTarget.value,
        'content': this.adviceTarget.value,
        'prescription': this.prescriptionTarget.value
      })
      });

  };
}
