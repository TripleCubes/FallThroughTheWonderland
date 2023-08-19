extends Node

@onready var _coin_result: = get_node(Consts.UI_PATH + "CoinResult")

func flip() -> void:
	var flip_result: = randi_range(0, 1)
	_coin_result.flipped(flip_result)
