if (dragging && global.dragged_instance == id) {
	draw_sprite_ext(sprite_index,image_index,x+5,y+5,image_xscale,image_yscale,image_angle,c_black,image_alpha);
}
draw_self();
