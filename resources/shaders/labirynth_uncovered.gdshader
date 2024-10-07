shader_type canvas_item;

uniform sampler2D tex : repeat_enable;
uniform float tiling = 1;
uniform float ratio = 1.0;
uniform vec2 tex_size = vec2(128.0, 128.0);

varying vec2 world_pos;
void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
	world_pos.y *= ratio;
}

void fragment() {
	vec2 tex_uv = vec2(tiling, tiling) / tex_size;
	vec2 new_uv = world_pos * tex_uv;
	//COLOR.rgb = texture(tex, new_uv).rgb;
    COLOR = vec4(new_uv.xy, 0.0, 1.0);
}