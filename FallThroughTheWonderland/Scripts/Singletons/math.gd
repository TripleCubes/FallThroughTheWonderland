extends Node

func distance_point_to_line(point: Vector2, line_p1: Vector2, line_p2: Vector2):
	var m: float = (line_p2.y - line_p1.y) / (line_p2.y - line_p1.y)
	var n: float = line_p1.y - m*line_p1.x

	var a: = m
	var b: = -1
	var c: = n

	return abs(a * point.x + b * point.y + c) / sqrt(a*a + b*b)

# From https://stackoverflow.com/a/3461533
func point_same_side_as_line_dir(point: Vector2, line_p1: Vector2, line_p2: Vector2) -> bool:
	var vec: = line_p2 - line_p1
	vec = vec.rotated(deg_to_rad(90))

	var a: = line_p1
	var b: = line_p1 + vec
	var c: = point
	return (b.x - a.x)*(c.y - a.y) - (b.y - a.y)*(c.x - a.x) > 0;
