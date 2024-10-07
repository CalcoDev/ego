shader_type canvas_item;

uniform sampler2D tex: hint_screen_texture;

uniform vec2 r_displacement = vec2(3.0, 0.0);
uniform vec2 g_displacement = vec2(0.0, 0.0);
uniform vec2 b_displacement = vec2(-3.0, 0.0);

uniform float outerRadius : hint_range(0.0, 5.0) = 1.0;

void fragment() {
   	float x = abs(UV.x-.5)*2.0;
	float y = abs(UV.y-.5)*2.0;
	float v = (sqrt((x*x)+(y*y))/outerRadius);
    
	float r = texture(tex, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE*r_displacement), 0.0).r;
	float g = texture(tex, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE*g_displacement), 0.0).g;
	float b = texture(tex, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE*b_displacement), 0.0).b;
	
	COLOR = vec4(r, g, b, v);
    //COLOR  =vec4(1.0, 1.0, 1.0, 1.0);
    //COLOR = texture(tex, SCREEN_UV);
}