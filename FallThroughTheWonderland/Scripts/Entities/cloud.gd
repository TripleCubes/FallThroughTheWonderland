extends StaticBody2D

const ATTACK_DELAY: float = 3

const _rain_scene: PackedScene = preload("res://Scenes/Entities/rain.tscn")
@onready var _rain_list: = get_node(Consts.MAIN_PATH + "Rains")

@onready var rnd_time: float = randf_range(0, 1000)

var _timer: float = 0

func _process(_delta):
	$Cloud.position.y = sin(float(Time.get_ticks_msec() + rnd_time) / 100) * 0.5

	if not GlobalVars.game_started:
		return

	if GlobalFunctions.get_effects_stats().get_duration(EffectNames.Names.CLOUD_FIRE_FASTER) > 0:
		_timer += (_delta / ATTACK_DELAY) * 4
	else:
		_timer += _delta / ATTACK_DELAY

	if _timer > 1:
		_timer = 0
		var rain = _rain_scene.instantiate()
		rain.dir = (GlobalFunctions.get_fairy_pos_center() - self.global_position).normalized()
		rain.global_position = self.global_position
		_rain_list.add_child(rain)
