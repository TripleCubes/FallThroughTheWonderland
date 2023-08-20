extends Node2D

@onready var _rain_list: = get_node(Consts.MAIN_PATH + "Rains")
@onready var _coin_list: = get_node(Consts.MAIN_PATH + "Coins")

func _ready():
	$Sprite2D.material.set_shader_parameter("darkness_enabled", true) 
	
func _process(_delta):
	_set_glow_list()
	
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

	$Sprite2D.material.set_shader_parameter("glow_list_size", list.size())
	$Sprite2D.material.set_shader_parameter("glow_list", list)
