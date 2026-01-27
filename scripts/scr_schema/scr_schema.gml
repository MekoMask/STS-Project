function diagnosis_schema() 
{
	schema =
	{
		diagnosis: "<one diagnosis from the list>",
		medication: "<one medication from the list>"
	};

	/*
	schema = {
	        type: "object",
	        properties: {
	            results: {
	                type: "object",
	                properties: {
	                    diagnosis: {
	                        type: "string",
	                        list: [
	                            "common_cold",
	                            "flu",
	                            "allergy",
	                            "food_poisoning",
	                            "healthy"
	                        ]
	                    },
	                    medication: {
	                        type: "string",
	                        list: [
	                            "rest",
	                            "antihistamine",
	                            "antibiotics",
	                            "painkillers",
	                            "none"
	                        ]
	                    }
	                },
	                required: ["diagnosis", "medication"]
	            }
	        },
	        required: ["results"]
	    };
	*/
	
	schema_json = json_stringify(schema);
	show_debug_message("SCHEMA: " + string(schema_json));
	return schema_json;
	
}