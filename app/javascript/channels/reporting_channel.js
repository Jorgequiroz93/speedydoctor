import consumer from "./consumer"

consumer.subscriptions.create( "ReportingChannel",
  { received(data) {
    console.log("data: " + data);
    console.log("current_user_id: " + current_user_id);
    if (data.patient_id === current_user_id) {
      console.log("patient_id: " + data.patient_id);
      console.log("consultation_id: " + data.consultation_id);
      console.log("advice (report.content): " + data.advice);
      console.log("prescription (report.prescription): " + data.prescription);

    //   { patient_id: @consultation.patient_id,
    //     consultation_id: @consultation.id,
    //     perscription: params["prescription"],
    //     advice: params["content"] }
    // )

      document.getElementById('advice').innerText = data.advice;
      document.getElementById('prescription').innerText = data.prescription;
    }
  }});
