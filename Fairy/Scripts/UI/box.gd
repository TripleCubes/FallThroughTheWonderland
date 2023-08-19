@tool
class_name Box
extends Node2D

const FLICK_DURATION_SEC: float = 2
const FLICK_ALTERNATE_SEC: float = 0.4

var _flick_progress: float = 1
var _draw_box: = false

@export var w: float
@export var h: float
@export var color: Color

func start_flick() -> void:
	_flick_progress = 0

func _draw():
	if not _draw_box:
		return

	# draw_rect(Rect2(0, 0, w * 2, h * 2), Color(0, 0, 0), true)

	# Top
	draw_rect(Rect2(1,     -1,    w * 2 - 2, 1        ), color, true)
	# Bottom
	draw_rect(Rect2(1,     h * 2, w * 2 - 2, 1        ), color, true)
	# Left
	draw_rect(Rect2(-1,    1,     1,         h * 2 - 2), color, true)
	# Right
	draw_rect(Rect2(w * 2, 1,     1,         h * 2 - 2), color, true)

	# Top left
	draw_rect(Rect2(0,         0,         1, 1), color, true)
	# Top right
	draw_rect(Rect2(w * 2 - 1, 0,         1, 1), color, true)
	# Bottom left
	draw_rect(Rect2(0,         h * 2 - 1, 1, 1), color, true)
	# Bottom right
	draw_rect(Rect2(w * 2 - 1, h * 2 - 1, 1, 1), color, true)

func _process(_delta):
	_flick(_delta)
	queue_redraw()

func _flick(_delta: float) -> void:
	_flick_progress += _delta / FLICK_DURATION_SEC
	if _flick_progress > 1:
		_draw_box = false
		return

	if fmod(_flick_progress * FLICK_DURATION_SEC, FLICK_ALTERNATE_SEC * 2) < FLICK_ALTERNATE_SEC:
		_draw_box = true
	else:
		_draw_box = false
