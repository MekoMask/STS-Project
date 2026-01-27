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

curr_report = string("Patient presents with " + string(diagnosis) + "\nand has been prescribed " + string(medication));

global.state = GameState.REVIEWING_REPORT;

if (!report_object_created) {
    var inst = instance_create_depth(0, 0, 0, obj_document);
    inst.report_text = curr_report;
    report_object_created = true;
}

//show_message("Patient presents with " + string(diagnosis) + " and has been prescribed " + string(medication))