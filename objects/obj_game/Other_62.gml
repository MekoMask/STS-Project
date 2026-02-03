/*
var response_json = async_load[? "result"];
var data = json_parse(response_json);

var content = json_parse(data.response.content);
var results = content.results;

var diagnosis  = results.diagnosis;
var medication = results.medication;
*/

var response_json = async_load[? "result"];
show_debug_message(response_json);
var data = json_parse(response_json);

var inner_data = json_parse(data.response);

var results = inner_data.results
var diagnosis  = results.diagnosis
var medication = results.medication

var d = []

array_push(d, document_elements_create("Patient presents with ",["term"],true,1));
array_push(d, document_elements_create(string(diagnosis),["var"],false,1));
array_push(d, document_elements_create(" and has been prescribed ",["term"],true,1));
array_push(d, document_elements_create(string(medication),["var"],false,1));

global.state = GameState.REVIEWING_REPORT;

if (!report_object_created) {
    var inst = instance_create_depth(0, 0, 0, obj_document);
    inst.report_text = d;
    report_object_created = true;
}

//show_message("Patient presents with " + string(diagnosis) + " and has been prescribed " + string(medication))