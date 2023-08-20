extends Node2D

@onready var _camera: = get_node(Consts.MAIN_PATH + "Fairy/Camera2D")
@onready var _fairy: = get_node(Consts.MAIN_PATH + "Fairy")
@onready var _fairy_sprite: = get_node(Consts.MAIN_PATH + "Fairy/Sprite")
@onready var _coin_list: = get_node(Consts.MAIN_PATH + "Coins")
@onready var _mushroom_list: = get_node(Consts.MAIN_PATH + "Mushrooms")
@onready var _map: TileMap = get_node(Consts.MAIN_PATH + "TileMap")

func is_solid_tile(pos: Vector2) -> bool:
	var tile_pos: = Vector2i(floor(pos.x / 10), floor(pos.y / 10))
	var tile: = _map.get_cell_atlas_coords(0, tile_pos)
	if tile == Vector2i(-1, -1):
		return false
	return true

func get_mushroom_list() -> Node2D:
	return _mushroom_list

func get_coin_list() -> Node2D:
	return _coin_list

func can_place_coin(pos: Vector2) -> bool:
	for i in range(_coin_list.get_child_count() - 1, -1, -1):
		var coin: = _coin_list.get_child(i)
		if pos.distance_to(coin.position) < Consts.COIN_DISTANCES:
			return false

	return true

func can_place_mushroom(pos: Vector2) -> bool:
	for i in range(_mushroom_list.get_child_count() - 1, -1, -1):
		var mushroom: = _mushroom_list.get_child(i)
		if pos.distance_to(mushroom.position) < Consts.MUSHROOM_DISTANCES:
			return false

	return true

func get_fairy() -> Node2D:
	return _fairy

func get_fairy_pos_center() -> Vector2:
	return _fairy_sprite.global_position

func get_fairy_pos() -> Vector2:
	return _fairy.global_position

func get_cam_pos() -> Vector2:
	var window_wh: = Vector2(get_viewport().size.x, get_viewport().size.y)
	var cam_pos: Vector2 = _camera.get_screen_center_position()
	return cam_pos - window_wh/4

func get_mouse_pos() -> Vector2:
	return get_global_mouse_position() / Consts.CAMERA_SCALE + get_cam_pos()

func get_local_mouse_pos(node: Node2D) -> Vector2:
	return get_mouse_pos() - node.position
