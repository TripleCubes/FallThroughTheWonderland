extends Node2D

@onready var _camera: = get_node(Consts.MAIN_PATH + "Fairy/Camera2D")
@onready var _fairy: = get_node(Consts.MAIN_PATH + "Fairy")
@onready var _fairy_sprite: = get_node(Consts.MAIN_PATH + "Fairy/Sprite")
@onready var _coin_list: = get_node(Consts.MAIN_PATH + "Coins")
@onready var _mushroom_list: = get_node(Consts.MAIN_PATH + "Mushrooms")
@onready var _cloud_list: = get_node(Consts.MAIN_PATH + "Clouds")
@onready var _map: TileMap = get_node(Consts.MAIN_PATH + "TileMap")

@onready var _stats = get_node(Consts.UI_PATH + "Stats")
@onready var _effects_stats = get_node(Consts.UI_PATH + "Stats/Effects")
@onready var _tutorial = get_node(Consts.UI_PATH + "Tutorial")

@onready var _pause_menu = get_node("/root/View/Menus/PauseMenu")
@onready var _restart_menu = get_node("/root/View/Menus/RestartMenu")

func toggle_pause_menu() -> void:
	if not _pause_menu.visible:
		GlobalVars.showing_menus = true
		_pause_menu.show()
	else:
		GlobalVars.showing_menus = false
		_pause_menu.hide()

func show_restart_menu() -> void:
	GlobalVars.showing_menus = true
	_restart_menu.show()

func get_tutorial() -> Node2D:
	return _tutorial

func get_stats() -> Node2D:
	return _stats

func get_effects_stats() -> Node2D:
	return _effects_stats

func is_solid_tile(pos: Vector2) -> bool:
	var tile_pos: = Vector2i(floor(pos.x / 10), floor(pos.y / 10))
	var tile: = _map.get_cell_atlas_coords(0, tile_pos)
	if tile == Vector2i(-1, -1):
		return false
	return true

func get_coin_list() -> Node2D:
	return _coin_list

func get_mushroom_list() -> Node2D:
	return _mushroom_list

func get_cloud_list() -> Node2D:
	return _cloud_list

func can_place_coin(pos: Vector2) -> bool:
	for i in range(_coin_list.get_child_count() - 1, -1, -1):
		var coin: = _coin_list.get_child(i)
		if pos.distance_to(coin.position) < Consts.COIN_DISTANCES:
			return false

	return true

func can_place_mushroom(pos: Vector2) -> bool:
	var fairy_tile_y: = get_fairy_pos().y / 10

	for i in range(_mushroom_list.get_child_count() - 1, -1, -1):
		var mushroom: = _mushroom_list.get_child(i)
		if pos.distance_to(mushroom.position) < Consts.MUSHROOM_DISTANCES - fairy_tile_y/3:
			return false

	return true

func can_place_cloud(pos: Vector2) -> bool:
	var fairy_tile_y: = get_fairy_pos().y / 10

	for i in range(_cloud_list.get_child_count() - 1, -1, -1):
		var cloud: = _cloud_list.get_child(i)
		if pos.distance_to(cloud.position) < Consts.CLOUD_DISTANCES - fairy_tile_y/3:
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

func pos_on_screen(pos: Vector2) -> bool:
	var viewport_pos: = pos - get_cam_pos()
	return viewport_pos.x >= 0 and viewport_pos.x <= 500 and viewport_pos.y >= 0 and viewport_pos.y <= 300

func get_aim_snap_result(line_p1: Vector2, line_p2: Vector2) -> Dictionary:
	var result: = {
		min_dist = 99999999,
		choosen = null,
		pos = Vector2(0, 0),
		dir = Vector2(0, 0),
		found = false,
		rotated_dir_p1 = line_p1,
		rotated_dir_p2 = Vector2(0, 0)
	}
	var vec: = line_p2 - line_p1
	vec = vec.rotated(deg_to_rad(-90))
	result.rotated_dir_p2 = line_p1 + vec

	var search: Callable = func(node: Node2D, offset_y: float, result: Dictionary):
		for enemy in node.get_children():
			var enemy_pos: = Vector2(enemy.global_position.x, enemy.global_position.y + offset_y * enemy.scale.y)

			if not pos_on_screen(enemy_pos):
				continue

			if not Math.point_same_side_as_line_dir(enemy_pos, line_p1, line_p2):
				continue

			var dist: = Math.distance_point_to_line(enemy_pos, line_p1, line_p2)
			if dist < result.min_dist:
				result.min_dist = dist
				result.choosen = enemy
				result.pos = enemy_pos
				result.dir = (enemy_pos - line_p1).normalized()
				result.found = true

	search.call(_mushroom_list, -5, result)
	search.call(_cloud_list, 0, result)

	return result

func clear_all_enemies() -> void:
	clear_list(_cloud_list)
	clear_list(_mushroom_list)

func clear_list(list: Node2D) -> void:
	for element in list.get_children():
		element.queue_free()

func show_fade(node: Node, wait: float, fade_time: float, duration: float) -> void:
	var timer = get_tree().create_timer(wait)
	timer.timeout.connect(func():
		var tween: = get_tree().create_tween()
		tween.tween_property(node, "modulate", Color(1, 1, 1, 1), fade_time)

		var timer_0: = get_tree().create_timer(duration)
		timer_0.timeout.connect(func():
			var tween_0: = get_tree().create_tween()
			tween_0.tween_property(node, "modulate", Color(1, 1, 1, 0), fade_time)
		)
	)
