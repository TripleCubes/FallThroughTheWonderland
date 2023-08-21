@tool
class_name Line
extends Node2D

@export var line_vec: Vector2:
	set(val):
		line_vec = val
		queue_redraw()

func _draw():
	draw_rect(Rect2(0, 0, line_vec.x, line_vec.y), Color(1, 1, 1), true)
