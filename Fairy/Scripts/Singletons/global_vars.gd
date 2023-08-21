extends Node

@onready var _map: TileMap = get_node(Consts.MAIN_PATH + "TileMap")

var game_started: = false:
	set(val):
		game_started = val

		if game_started:
			_open_hole()
		else:
			GlobalFunctions.restart_game()

func _open_hole() -> void:
	for i in 19:
		var timer: = get_tree().create_timer(i * 0.05)
		timer.timeout.connect(func():
			_map.erase_cell(0, Vector2(24 - i, 0))
			_map.erase_cell(0, Vector2(25 + i, 0))
		)
