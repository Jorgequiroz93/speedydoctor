import consumer from "./consumer"

consumer.subscriptions.create( "CallsChannel",
  { received(data) {
    console.log("data: " + data);
    console.log("current_user_id: " + current_user_id);
    if (data.doctor_id === current_user_id) {
      console.log("doctor_id: " + data.doctor_id);
      console.log("consultation_id: " + data.consultation_id);
      if (confirm("Incoming call. Taking you to the consultation!") === true) {
        var url = new URL(location.href)
        location.href = `${url.origin}/consultations/${data.consultation_id}`;
      }
    }
  }});
