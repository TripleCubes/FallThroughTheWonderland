extends Node

@onready var _map: TileMap = get_node(Consts.MAIN_PATH + "TileMap")
@onready var _stats = get_node(Consts.UI_PATH + "Stats")
@onready var _effect_stats = get_node(Consts.UI_PATH + "Stats/Effects")
@onready var _coin_result = get_node(Consts.UI_PATH + "CoinResult")

@onready var _fairy: = get_node(Consts.MAIN_PATH + "Fairy")
@onready var _coin_list: = get_node(Consts.MAIN_PATH + "Coins")
@onready var _mushroom_list: = get_node(Consts.MAIN_PATH + "Mushrooms")
@onready var _cloud_list: = get_node(Consts.MAIN_PATH + "Clouds")
@onready var _rain_list: = get_node(Consts.MAIN_PATH + "Rains")

const _coin_scene: = preload("res://Scenes/Entities/coin.tscn")

var showing_menus: = true

var intro_shown: = false

var game_started: = false:
	set(val):
		game_started = val

		if game_started:
			_open_hole()
			var tween_0: = get_tree().create_tween()
			tween_0.tween_property(_stats, "position", Vector2(4, _stats.position.y), 
										1.2).set_trans(Tween.TRANS_SINE)
			var tween_1: = get_tree().create_tween()
			tween_1.tween_property(_coin_result, "position", Vector2(0, _coin_result.position.y), 
										1.2).set_trans(Tween.TRANS_SINE)

			if not intro_shown:
				_fairy.show_exclamation_mark()

			intro_shown = true
		else:
			_restart_game()

func _open_hole() -> void:
	for i in 19:
		var timer: = get_tree().create_timer(i * 0.05)
		timer.timeout.connect(func():
			_map.erase_cell(0, Vector2(24 - i, 0))
			_map.erase_cell(0, Vector2(25 + i, 0))
		)

func _restart_game() -> void:
	GlobalFunctions.clear_list(_coin_list)
	GlobalFunctions.clear_list(_mushroom_list)
	GlobalFunctions.clear_list(_cloud_list)
	GlobalFunctions.clear_list(_rain_list)

	_stats.coin_count = 0
	_stats.health_count = 3
	_stats.glow = 0

	_effect_stats.reset()
	_coin_result.reset()

	_map_reset()

	_fairy.velocity = Vector2(0, 0)
	_fairy.gravity = 0
	_fairy.position.x = 200
	_fairy.position.y = 0
	_fairy.get_node("Sprite").show()

	_map.next_load_point_y = _map.START_COPYING_AT

func _map_reset() -> void:
	for i in 19:
		_map.set_cell(0, Vector2(24 - i, 0), 0, Vector2(4, 3))
		_map.set_cell(0, Vector2(25 + i, 0), 0, Vector2(4, 3))

	for x in range(6, 44):
		for y in range(2, _map.next_load_point_y / 10):
			_map.erase_cell(0, Vector2(x, y))

	var first_coin = _coin_scene.instantiate()
	first_coin.position.x = 250
	first_coin.dont_flip = true
	_coin_list.add_child(first_coin)
