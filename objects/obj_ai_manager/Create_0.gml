function call_ai(symptoms) {
	var url = "http://localhost:11434/api/generate";

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
	symptoms;

	//show_debug_message(_prompt)

	var payload = {
	    model: "llama3.1",
	    prompt: _prompt,
	    stream: false
	};

	var headers =	ds_map_create()
	ds_map_add(headers, "Content-Type", "application/json");

	http_request(
	    url,
	    "POST",
	    headers,
	    json_stringify(payload)
	);
}