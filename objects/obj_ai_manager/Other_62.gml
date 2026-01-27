var response_json = async_load[? "result"];
var data = json_parse(response_json);

var inner_data = json_parse(data.response);

var results = inner_data.results
var diagnosis  = results.diagnosis
var medication = results.medication

show_message("Patient presents with " + string(diagnosis) + " and has been prescribed " + string(medication))