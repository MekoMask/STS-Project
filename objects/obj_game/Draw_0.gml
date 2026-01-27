if (global.state == GameState.REVIEWING_REPORT) {
    //draw_report_ui(curr_report);
	draw_set_colour(c_white);
	//draw_text(100,0,curr_patient.symptoms);
	draw_text(100,0,curr_patient.disease);
	//draw_text(100,100,curr_report);
}

draw_text(0,0,global.state);