shader_type canvas_item;

const float OTHER_GLOW_DISTANCE = 35.0;
const float GLOW_FADE_DISTANCE = 10.0;

uniform float fairy_glow_distance = 0.0;

uniform vec2 fairy_pos_on_cam;
uniform bool darkness_enabled = false;

uniform vec2 glow_list[50];
uniform int glow_list_size;

float glow_curve(float glow_value, float max_glow_distance) {
	if (max_glow_distance - glow_value > GLOW_FADE_DISTANCE) {
		return 1.0;
	}

	return (max_glow_distance - glow_value) / GLOW_FADE_DISTANCE;
}

float glow(vec2 pixel_pos) {	
	if (!darkness_enabled) {
		return 1.0;
	}

	float result = 0.0;

	result = max(result, glow_curve(distance(pixel_pos, fairy_pos_on_cam), fairy_glow_distance));

	for (int i = 0; i < glow_list_size; i++) {
		result = max(result, glow_curve(distance(pixel_pos, glow_list[i]), OTHER_GLOW_DISTANCE));
	}

	return result;
}

void fragment() {
	vec2 pixel_pos = vec2(UV.x / SCREEN_PIXEL_SIZE.x, UV.y / SCREEN_PIXEL_SIZE.y);
	pixel_pos = pixel_pos / 2.0;
	vec4 texture_color = texture(TEXTURE, UV);
	texture_color.a *= glow(pixel_pos);
	COLOR = texture_color;
}
