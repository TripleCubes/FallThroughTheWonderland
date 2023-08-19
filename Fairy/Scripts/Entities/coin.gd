extends Node2D

const FLIP_TIME_SEC: float = 1
const FLIP_HEIGHT: float = 50
const FLIP_ROTATION_SPEED_DEGREE_PER_SEC: float = 360

@onready var _coin_result: = get_node(Consts.UI_PATH + "CoinResult")
@onready var _stats = get_node(Consts.UI_PATH + "Stats")

@onready var rnd_time: float = randf_range(0, 1000)

var flip_progress: float = 0

func _process(_delta):
	_animate_not_flipping_coin()
	_flip_animation(_delta)

func _on_area_2d_area_entered(area):
	if $CoinSide.visible or $Num/Num1.visible or $Num/Num0.visible:
		return

	if area == GlobalFunctions.get_fairy().area:
		_start_flip_animation()

func _animate_not_flipping_coin() -> void:
	$Coin.position.y = -10 + sin(float(Time.get_ticks_msec() + rnd_time) / 100) * 0.5

func _start_flip_animation() -> void:
	$Coin.hide()
	$CoinSide.show()

func _flip_animation(_delta: float) -> void:
	if not $CoinSide.visible:
		return

	var start_y: float = -10

	flip_progress += _delta / FLIP_TIME_SEC
	$CoinSide.position.y = start_y - sin(flip_progress * PI) * FLIP_HEIGHT
	$CoinSide.rotation_degrees += FLIP_ROTATION_SPEED_DEGREE_PER_SEC * _delta

	if not flip_progress > 1:
		return

	var flip_result: = randi_range(0, 1)
	_coin_result.flipped(flip_result)
	_stats.coin_count += 1
	_start_number_animation(flip_result)

func _start_number_animation(num: int) -> void:
	$CoinSide.hide()
	if num == 1:
		$Num/Num1.show()
	else:
		$Num/Num0.show()

	var tween_0: = get_tree().create_tween()
	tween_0.tween_property($Num, "position", Vector2(0, -20), Consts.COIN_FLIP_TIME_SEC)

	var timer_0: = get_tree().create_timer(0.4)
	timer_0.timeout.connect(func():
		var tween_1: = get_tree().create_tween()
		tween_1.tween_property($Num, "modulate", Color(0, 0, 0, 0), Consts.COIN_FLIP_TIME_SEC/2)
	)

	var timer_1: = get_tree().create_timer(Consts.COIN_FLIP_TIME_SEC)
	timer_1.timeout.connect(func():
		queue_free()
	)
