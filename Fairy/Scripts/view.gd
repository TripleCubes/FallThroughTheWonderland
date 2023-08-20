extends Node2D

@onready var _rain_list: = get_node(Consts.MAIN_PATH + "Rains")
@onready var _coin_list: = get_node(Consts.MAIN_PATH + "Coins")
@onready var _thrown_coin_list: = get_node(Consts.MAIN_PATH + "ThrownCoins")

func _ready():
	$Sprite2D.material.set_shader_parameter("darkness_enabled", true) 
	
func _process(_delta):
	_set_glow_list()

	if GlobalFunctions.get_effects_stats().get_duration(EffectNames.Names.LIGHT) > 0:
		$Sprite2D.material.set_shader_parameter("fairy_glow_distance", 150)
	elif GlobalFunctions.get_stats().glow != 0:
		$Sprite2D.material.set_shader_parameter("fairy_glow_distance", 75)
	else:
		$Sprite2D.material.set_shader_parameter("fairy_glow_distance", 25)

	$Sprite2D.material.set_shader_parameter("fairy_pos_on_cam", 
									GlobalFunctions.get_fairy_pos_center() - GlobalFunctions.get_cam_pos())

func _set_glow_list() -> void:
	var list: = []
	
	for i in _rain_list.get_child_count():
		if i > 24:
			break
		var rain: = _rain_list.get_child(_rain_list.get_child_count() - i - 1)
		list.append(rain.global_position - GlobalFunctions.get_cam_pos())
	
	for i in _coin_list.get_child_count():
		if i > 24:
			break
		var coin: = _coin_list.get_child(_coin_list.get_child_count() - i - 1)
		list.append(Vector2(coin.global_position.x, coin.global_position.y - 10) - GlobalFunctions.get_cam_pos())
	
	for i in _thrown_coin_list.get_child_count():
		if i > 10:
			break
		var thrown_coin: = _thrown_coin_list.get_child(_thrown_coin_list.get_child_count() - i - 1)
		list.append(thrown_coin.global_position - GlobalFunctions.get_cam_pos())

	$Sprite2D.material.set_shader_parameter("glow_list_size", list.size())
	$Sprite2D.material.set_shader_parameter("glow_list", list)
