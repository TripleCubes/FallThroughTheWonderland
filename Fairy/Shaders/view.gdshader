shader_type canvas_item;

uniform vec2 fairy_pos_on_cam;
uniform bool darkness_enabled = false;

void fragment() {
	vec2 pixel_pos = vec2(UV.x / SCREEN_PIXEL_SIZE.x, UV.y / SCREEN_PIXEL_SIZE.y);
	pixel_pos = pixel_pos / 2.0;
	if (!darkness_enabled || distance(pixel_pos, fairy_pos_on_cam) < 50.0) {
		vec4 texture_color = texture(TEXTURE, UV);
		COLOR = texture_color;
	} else {
		COLOR = vec4(0, 0, 0, 1);
	}
}
