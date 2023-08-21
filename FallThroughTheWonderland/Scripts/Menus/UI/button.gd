@tool
class_name Menus_Button
extends Button

func _ready():
	focus_mode = Control.FOCUS_NONE

func _draw():
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

func _process(_delta):
	queue_redraw()
