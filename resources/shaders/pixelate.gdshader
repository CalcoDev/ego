shader_type canvas_item;

uniform sampler2D tex: hint_screen_texture, filter_nearest;

void fragment() {
	COLOR = texture(tex, SCREEN_UV);
    //COLOR = vec4(1, 1, 1, 0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
