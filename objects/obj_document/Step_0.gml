// Start dragging
if (!dragging && mouse_check_button_pressed(mb_left)) {
    if (position_meeting(mouse_x, mouse_y, id)) {
        dragging = true;
        drag_offset_x = x - mouse_x;
        drag_offset_y = y - mouse_y;
    }
}

// Continue dragging
if (dragging) {
    x = mouse_x + drag_offset_x;
    y = mouse_y + drag_offset_y;
}

// Stop dragging
if (dragging && mouse_check_button_released(mb_left)) {
    dragging = false;
}
