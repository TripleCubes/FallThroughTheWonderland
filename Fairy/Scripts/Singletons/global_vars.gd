extends Node

@onready var _map: TileMap = get_node(Consts.MAIN_PATH + "TileMap")
@onready var _stats = get_node(Consts.UI_PATH + "Stats")
@onready var _coin_result = get_node(Consts.UI_PATH + "CoinResult")

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
		else:
			GlobalFunctions.restart_game()

func _open_hole() -> void:
	for i in 19:
		var timer: = get_tree().create_timer(i * 0.05)
		timer.timeout.connect(func():
			_map.erase_cell(0, Vector2(24 - i, 0))
			_map.erase_cell(0, Vector2(25 + i, 0))
		)
