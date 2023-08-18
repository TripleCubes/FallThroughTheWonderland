extends Node2D

@onready var _camera: = get_node("/root/View/SubViewport/Main/Fairy/Camera2D")

func get_mouse_pos() -> Vector2:
	var window_wh = Vector2(get_viewport().size.x, get_viewport().size.y)
	var cam_pos = _camera.get_screen_center_position()
	return get_global_mouse_position() / Consts.CAMERA_SCALE + cam_pos - window_wh/4

func get_local_mouse_pos(node: Node2D) -> Vector2:
	return get_mouse_pos() - node.position
