@tool
class_name Menus_Box
extends Node2D

@export var size: Vector2:
	set(val):
		size = val
		queue_redraw()

func _draw():
	draw_rect(Rect2(0, 0, size.x, size.y), Color(0, 0, 0), true)

	# Top
	draw_rect(Rect2(1,      -1,     size.x - 2, 1         ), Color(1, 1, 1), true)
	# Bottom
	draw_rect(Rect2(1,      size.y, size.x - 2, 1         ), Color(1, 1, 1), true)
	# Left
	draw_rect(Rect2(-1,     1,      1,          size.y - 2), Color(1, 1, 1), true)
	# Right
	draw_rect(Rect2(size.x, 1,      1,          size.y - 2), Color(1, 1, 1), true)

	# Top left
	draw_rect(Rect2(0,          0,          1, 1), Color(1, 1, 1), true)
	# Top right
	draw_rect(Rect2(size.x - 1, 0,          1, 1), Color(1, 1, 1), true)
	# Bottom left
	draw_rect(Rect2(0,          size.y - 1, 1, 1), Color(1, 1, 1), true)
	# Bottom right
	draw_rect(Rect2(size.x - 1, size.y - 1, 1, 1), Color(1, 1, 1), true)
