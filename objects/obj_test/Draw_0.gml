if (keyboard_check_pressed(ord("E"))) {
	global.debug_mode = !global.debug_mode;
}

doc_layout(d,x,y,8);

c = doc_line_at_mouse(d);

if keyboard_check(vk_control) {
	if (c != -1) {
		draw_set_color(c_white);
		draw_rectangle(d[c].x1,d[c].y1,d[c].x2,d[c].y2,false);
	
		if mouse_check_button_pressed(mb_left) {
			document_select_line(d,c);
		}
	}
}
for (var i = 0; i < array_length(global.lines_selected); i++) {
	var s = global.lines_selected[i];
	draw_set_color(c_yellow);
	draw_rectangle(s.x1,s.y1,s.x2,s.y2,false);
}

document_draw(d);

//debug
if (global.debug_mode) {
	draw_set_color(c_white);
	draw_text(0,200,global.lines_selected);
	draw_text(0,100,c);
}