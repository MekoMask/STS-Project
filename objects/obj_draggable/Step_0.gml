// Attempt to start dragging
if (
	global.dragged_instance == noone &&
	mouse_check_button_pressed(mb_left)
) {
	// Find the topmost instance of THIS object type under the mouse
	var top = instance_position(mouse_x, mouse_y, obj_draggable);

	if (top == id) {
	    global.dragged_instance = id;
	    dragging = true;
		
		var i = array_get_index(global.draggable_array,self);
		array_delete(global.draggable_array,i,1);
		array_push(global.draggable_array,self);

	    drag_offset_x = x - mouse_x;
	    drag_offset_y = y - mouse_y;
		
		// Place this object on the top of the layer
		
	}
}

// Continue dragging (only if THIS instance owns the drag)
if (dragging && global.dragged_instance == id) {
	x = mouse_x + drag_offset_x;
	y = mouse_y + drag_offset_y;
}

// Release drag
if (
	dragging &&
	global.dragged_instance == id &&
	mouse_check_button_released(mb_left)
) {
	dragging = false;
	global.dragged_instance = noone;
}

// This feels really stupid LMAO
// Basically, there's an array with every draggable object.
// When you get picked up, you're put on the top of the array.
var d = array_get_index(global.draggable_array,self);
depth = -d;