@tool
class_name Box
extends Node2D

@export var w: float:
	set(val):
		w = val
		queue_redraw()

@export var h: float:
	set(val):
		h = val
		queue_redraw()

func _draw():
	draw_rect(Rect2(0, 0, w * 2, h * 2), Color(0, 0, 0), true)

	# Top
	draw_rect(Rect2(1,     -1,    w * 2 - 2, 1        ), Color(1, 1, 1), true)
	# Bottom
	draw_rect(Rect2(1,     h * 2, w * 2 - 2, 1        ), Color(1, 1, 1), true)
	# Left
	draw_rect(Rect2(-1,    1,     1,         h * 2 - 2), Color(1, 1, 1), true)
	# Right
	draw_rect(Rect2(w * 2, 1,     1,         h * 2 - 2), Color(1, 1, 1), true)

	# Top left
	draw_rect(Rect2(0,         0,         1, 1), Color(1, 1, 1), true)
	# Top right
	draw_rect(Rect2(w * 2 - 1, 0,         1, 1), Color(1, 1, 1), true)
	# Bottom left
	draw_rect(Rect2(0,         h * 2 - 1, 1, 1), Color(1, 1, 1), true)
	# Bottom right
	draw_rect(Rect2(w * 2 - 1, h * 2 - 1, 1, 1), Color(1, 1, 1), true)
