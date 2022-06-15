import { Controller } from "stimulus";
import { csrfToken } from '@rails/ujs';

export default class extends Controller {
  static targets = [ "patientNotes" ];

  connect() {
    console.log('Patient saver stimulus connected!');
  }

  save() {
    console.log('saving ', this.patientNotesTarget.value, ' via PATCH to: ', window.location.href );
    document.getElementById('notes_label').innerHTML = "My personal notes ... <span style='color: #E67E22'>typing...</span>";
    fetch(window.location.href, {
      method: 'PATCH',
      headers: {'Content-Type': 'application/json', "X-CSRF-Token": csrfToken()},
      body: JSON.stringify({'patient_notes': this.patientNotesTarget.value})
      }).then(setTimeout(() => {
        document.getElementById('notes_label').innerHTML = "My personal notes ... <span style='color: #84DCC6'>saved ✓</span>";
      }, 2000));
  }
}
