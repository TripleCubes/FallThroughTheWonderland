shader_type canvas_item;

const float FAIRY_GLOW_DISTANCE = 50.0;
const float OTHER_GLOW_DISTANCE = 35.0;

uniform vec2 fairy_pos_on_cam;
uniform bool darkness_enabled = false;

uniform vec2 glow_list[50];
uniform int glow_list_size;

bool glow(vec2 pixel_pos) {
	if (!darkness_enabled) {
		return true;
	}

	if (distance(pixel_pos, fairy_pos_on_cam) < FAIRY_GLOW_DISTANCE) {
		return true;
	}

	for (int i = 0; i < glow_list_size; i++) {
		if (distance(pixel_pos, glow_list[i]) < OTHER_GLOW_DISTANCE) {
			return true;
		}
	}

	return false;
}

void fragment() {
	vec2 pixel_pos = vec2(UV.x / SCREEN_PIXEL_SIZE.x, UV.y / SCREEN_PIXEL_SIZE.y);
	pixel_pos = pixel_pos / 2.0;
	if (glow(pixel_pos)) {
		vec4 texture_color = texture(TEXTURE, UV);
		COLOR = texture_color;
	} else {
		COLOR = vec4(0, 0, 0, 1);
	}
}
