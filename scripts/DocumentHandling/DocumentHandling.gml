function document_elements_create(_text, _tags = "", _correct = true, _ref_id = -1)
{
	return {
		str: _text, // text
		tags: _tags, // relevant info
		correct: _correct, // is this correct
		ref_id: _ref_id, // the glossary element this relates to
		x1 : 0, y1 : 0, x2 : 0, y2 : 0
	};
}

function doc_layout(doc, _x, _y, line_spacing)
{
    var yy = _y;
	var xx = _x;

    for (var i = 0; i < array_length(doc); i++) {
        var h = string_height(doc[i].str);
        var w = string_width(doc[i].str);

        doc[i].x1 = xx;
        doc[i].y1 = _y;
        doc[i].x2 = xx + w;
        doc[i].y2 = _y + h;
		
		xx += w + line_spacing;
		
        //yy += h + line_spacing;
    }
}

function document_draw(doc)
{
	 for (var i = 0; i < array_length(doc); i++) {
        var l = doc[i];

        if (l.correct == false) draw_set_color(c_red);
        else draw_set_color(c_black);

        draw_text(l.x1, l.y1, l.str);
    }
}

function doc_line_at_mouse(doc)
{
    for (var i = 0; i < array_length(doc); i++) {
        var l = doc[i];
        if (
            mouse_x >= l.x1 && mouse_x <= l.x2 &&
            mouse_y >= l.y1 && mouse_y <= l.y2
        ) {
			return i;
        }
    }
    return -1;
}

function document_select_line(doc, line) {	
	// Verify that this is a term or variable
	if (array_contains(doc[line].tags,"term")) {
		for (var i = 0; i < array_length(global.lines_selected); i++) {
			if (array_contains(global.lines_selected[i].tags,"term")) {
				if (global.lines_selected[i] = doc[line]) {
					array_delete(global.lines_selected,i,1);
					return;
				}
				array_delete(global.lines_selected,i,1);
				array_push(global.lines_selected,doc[line]);
				return;
			}
		}
		array_push(global.lines_selected,doc[line]);
		return;	
	}
	if (array_contains(doc[line].tags,"var")) {
		for (var i = 0; i < array_length(global.lines_selected); i++) {
			if (array_contains(global.lines_selected[i].tags,"var")) {
				if (global.lines_selected[i] = doc[line]) {
					array_delete(global.lines_selected,i,1);
					return;
				}
				array_delete(global.lines_selected,i,1);
				array_push(global.lines_selected,doc[line]);
				return;
			}
		}
		array_push(global.lines_selected,doc[line]);
		return;
	}
	return;
}

function document_full_draw(text, xx, yy, spacing) {
	doc_layout(text,xx,yy,spacing);

	var c = doc_line_at_mouse(text);

	if keyboard_check(vk_control) {
		if (c != -1) {
			draw_set_color(c_white);
			draw_rectangle(text[c].x1,text[c].y1,text[c].x2,text[c].y2,false);
	
			if mouse_check_button_pressed(mb_left) {
				document_select_line(text,c);
			}
		}
	}
	for (var i = 0; i < array_length(global.lines_selected); i++) {
		var s = global.lines_selected[i];
		draw_set_color(c_yellow);
		draw_rectangle(s.x1,s.y1,s.x2,s.y2,false);
	}

	document_draw(text);
}