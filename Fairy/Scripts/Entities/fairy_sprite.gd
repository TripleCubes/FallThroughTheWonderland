extends Node2D

const FLICK_DURATION_SEC: float = 3
const FLICK_ALTERNATE_SEC: float = 0.4

var flicking: bool:
	get:
		return _flick_progress < 1

var _flick_progress: float = 1
var _draw_fairy: = false:
	set(val):
		_draw_fairy = val
		if _draw_fairy:
			self.show()
		else:
			self.hide()

func start_flick() -> void:
	_flick_progress = 0

func _process(_delta):
	_flick_progress += _delta / FLICK_DURATION_SEC
	if _flick_progress > 1:
		_draw_fairy = true
		return

	if fmod(_flick_progress * FLICK_DURATION_SEC, FLICK_ALTERNATE_SEC * 2) > FLICK_ALTERNATE_SEC:
		_draw_fairy = true
	else:
		_draw_fairy = false
