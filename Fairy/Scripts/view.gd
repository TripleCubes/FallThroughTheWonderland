extends Node2D

func _ready():
	$Sprite2D.material.set_shader_parameter("darkness_enabled", true) 
	
func _process(_delta):
	$Sprite2D.material.set_shader_parameter("fairy_pos_on_cam", 
									GlobalFunctions.get_fairy_pos_center() - GlobalFunctions.get_cam_pos())
