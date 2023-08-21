shader_type canvas_item;

const float OTHER_GLOW_DISTANCE = 35.0;
const float GLOW_FADE_DISTANCE = 10.0;

uniform float fairy_glow_distance = 0.0;

uniform vec2 fairy_pos_on_cam;
uniform bool darkness_enabled = false;

uniform vec2 glow_list[60];
uniform int glow_list_size;

uniform bool aim_snap_active = false;
uniform vec2 aim_snap_line_p2;
uniform vec2 aim_snap_rotated_dir_p1;
uniform vec2 aim_snap_rotated_dir_p2;

float distance_point_to_line(vec2 point, vec2 line_p1, vec2 line_p2) {
	float m = (line_p2.y - line_p1.y) / (line_p2.x - line_p1.x);
	float n = line_p1.y - m*line_p1.x;

	float a = m;
	float b = -1.0;
	float c = n;

	return abs(a * point.x + b * point.y + c) / sqrt(a*a + b*b);
}

// From https://stackoverflow.com/a/3461533
bool point_same_side_as_line_dir(vec2 point, vec2 rotated_dir_p1, vec2 rotated_dir_p2) {
	vec2 a = rotated_dir_p1;
	vec2 b = rotated_dir_p2;
	vec2 c = point;
	return (b.x - a.x)*(c.y - a.y) - (b.y - a.y)*(c.x - a.x) > 0.0;
}

float distance_point_to_line_dir(vec2 point, vec2 line_p1, vec2 line_p2, vec2 rotated_dir_p1, vec2 rotated_dir_p2) {
	if (point_same_side_as_line_dir(point, rotated_dir_p1, rotated_dir_p2)) {
		return distance_point_to_line(point, line_p1, line_p2);
	} else {
		return distance(point, line_p1);
	}
}

float glow_curve(float dist, float max_glow_distance) {
	if (max_glow_distance - dist > GLOW_FADE_DISTANCE) {
		return 1.0;
	}

	return (max_glow_distance - dist) / GLOW_FADE_DISTANCE;
}

float glow(vec2 pixel_pos) {	
	if (!darkness_enabled) {
		return 1.0;
	}

	float result = 0.0;

	result = max(result, glow_curve(distance(pixel_pos, fairy_pos_on_cam), fairy_glow_distance));

	if (aim_snap_active) {
		result = max(result, glow_curve(distance_point_to_line_dir(pixel_pos, fairy_pos_on_cam, aim_snap_line_p2, 
										aim_snap_rotated_dir_p1, aim_snap_rotated_dir_p2), OTHER_GLOW_DISTANCE));
	}

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
