#region Variables

report_object_created = false;

// Day
day_count = 0;

// Current time
day_curr_time = 0;

// End time
day_end_time = 1000;

// Number of people treated today
num_treated = 0;

// Incorrect diagnosis
num_wrong_diag = 0;

// Incorrect medication
num_wrong_med = 0;

#endregion

#region Create Diseases

// POSSIBLE SYMPTOMS
/*
fever
cough
sneezing
red eyes
stomach pain
fatigue
nothing
*/


// POSSIBLE TREATMENTS
/*
rest
antihistamine
antibiotics
painkillers
none
*/

// New Disease
// creates a struct containing the information for a new disease
// expandable
function new_disease(_name, _symptoms, _req_symptoms, _treatments) {
	return {
		d_name: _name,
		symps: _symptoms,
		req_symps: _req_symptoms,
		treat: _treatments
	};
}

// Create the list of diseases
global.disease_list = [
	// Flu
	new_disease(
		"flu",
		["fever","cough","fatigue"],
		["fever"],
		["antiviral","rest"]),
	// Common Cold
	new_disease(
		"common_cold",
		["cough","sneezing"],
		["sneezing"],
		["rest"]),
	// Allergy
	new_disease(
		"allergy",
		["red eyes","sneezing","cough"],
		["red_eyes"],
		["antihistamine"]),
	// Food Poisoning
	new_disease(
		"food_poisoning",
		["stomach_pain"],
		["stomach_pain"],
		["painkillers"]),
	// Healthy
	new_disease(
		"healthy",
		["stomach_pain","cough","fatigue"],
		[],
		["none"])	
	]
	
#endregion

function generate_symptoms(_disease)
{
	// Create an array, initially containing all required symptoms
	
	var _symps = [];
	
	//_symps = _disease.req_symps;
	
	// Add additional symptoms
	for (var i = 0; i < array_length(_disease.symps); i++) {
		// Verify the symptom is not already in the array
		if array_contains(_symps,_disease.symps[i]) { continue; }
		
		// 0.8 = 80% chance to have a given symptom added
        if (random(1) < 0.8) {
            array_push(_symps, _disease.symps[i]);
        }
    }
	return _symps;
}


// Create a new patient
function new_patient()
{
	var _disease = global.disease_list[
    irandom(array_length(global.disease_list) - 1)];
	
	var patient = {
		disease: _disease,
		symptoms: generate_symptoms(_disease),
	}
	
	return patient;
}

function ai_generate_report(symptoms) {
	
	var symptom_text = "";

	for (var i = 0; i < array_length(symptoms); i++) {
	    symptom_text += "- " + symptoms[i] + "\n";
	}
	///*
	// The AI has a chance of getting this wrong!	
	if (random(1) < 0.5) {
		var _prompt = "You are a medical diagnosis AI for a video game.\n" +
		"You MUST respond in valid JSON ONLY.\n" +
		"DO NOT include explanations, markdown, or extra text.\n\n" +

		"Allowed diagnoses:\n" +
		"- common_cold\n" +
		"- flu\n" +
		"- allergy\n" +
		"- food_poisoning\n" +
		"- healthy\n\n" +

		"Allowed medications:\n" +
		"- rest\n" +
		"- antihistamine\n" +
		"- antibiotics\n" +
		"- painkillers\n" +
		"- none\n\n" +

		"Return this exact JSON structure:\n" +
		"{\n" +
		"  results: {\n" +
		"    diagnosis: \"<one diagnosis from the list>\",\n" +
		"    medication: \"<one medication from the list>\"\n" +
		"  }\n" +
		"}\n\n" +

		"Patient symptoms:\n" +
		symptom_text;
	}
	else {
		// Bad response
		var _prompt = "You are a medical diagnosis AI for a video game.\n" +
		"You are simulating a faulty AI giving incorrect diagnoses that the player must identify.\n" +
		"You MUST respond in valid JSON ONLY.\n" +
		"DO NOT include explanations, markdown, or extra text.\n\n" +

		"Allowed diagnoses:\n" +
		"- common_cold\n" +
		"- flu\n" +
		"- allergy\n" +
		"- food_poisoning\n" +
		"- dead\n" +
		"- stupid\n" +
		"- healthy\n\n" +
		

		"Allowed medications:\n" +
		"- rest\n" +
		"- antihistamine\n" +
		"- antibiotics\n" +
		"- painkillers\n" +
		"- execution\n" +
		"- none\n\n" +

		"Return this exact JSON structure:\n" +
		"{\n" +
		"  results: {\n" +
		"    diagnosis: \"<one diagnosis from the list>\",\n" +
		"    medication: \"<one medication from the list>\"\n" +
		"  }\n" +
		"}\n\n" +

		"Patient symptoms:\n" +
		symptom_text;
	}
	//*/
	
	//var _prompt = 
	//"You are a medical diagnosis AI for a video game.\n" +
	//"You must return a JSON structure containing the diagnosis and prescribed medication.\n" +
	//"Symptoms:\n" + symptom_text
	
	var url = "http://localhost:11434/api/generate";
	
	/*
	var payload = {
	    model: "llama3.1",
	    prompt: _prompt,
	    stream: false
	};
	*/
	
	///*
	var payload = {
		model: "llama3.1",
		prompt: _prompt,
		stream: false,
		format: "json"			
	};
	//*/
	//show_debug_message(payload.format);

	var headers =	ds_map_create()
	ds_map_add(headers, "Content-Type", "application/json");

	http_request(
	    url,
	    "POST",
	    headers,
	    json_stringify(payload)
	);
	
	report_object_created = false;
}

global.state = GameState.IDLE;

enum GameState {
	IDLE, // The AI is not generating anything, the player is not reviewing anything
	GENERATING_PATIENT, // The AI is generating a patient (Given the way the generation system should ideally work, this should probably be changed)
	WAITING_FOR_AI, // Same as above
	REVIEWING_REPORT, // The player is reviewing a report, nothing needs to be done on the AI's side
	RESOLVING_DECISION // Whatever decision the player made is being resolved by the code. This shouldn't generally involve any AI.
}
	

// Current Patient
curr_patient = new_patient();
curr_report = ai_generate_report(curr_patient.symptoms);

// Next Patient
//next_patient = undefined;
//next_report = undefined;