// For each instanced patient, decide the disease and symptoms

// Patients may present with an addition symptom not from their disease
// Pass it to the AI and wait for a response

// Then, format the returned response in the same format as the original generated patient
// Finally, create a document to be sent to the player for verification.


if global.state == GameState.REVIEWING_REPORT {
	if keyboard_check_pressed(vk_space) {
		global.state = GameState.GENERATING_PATIENT;
		curr_patient = new_patient();
		curr_report = ai_generate_report(curr_patient.symptoms);
	}
}