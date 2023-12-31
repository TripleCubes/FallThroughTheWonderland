extends TileMap

const _coin_scene: PackedScene = preload("res://Scenes/Entities/coin.tscn")
const _mushroom_scene: PackedScene = preload("res://Scenes/Entities/mushroom.tscn")
const _cloud_scene: PackedScene = preload("res://Scenes/Entities/cloud.tscn")

@onready var _coin_list: = get_node(Consts.MAIN_PATH + "Coins")
@onready var _mushroom_list: = get_node(Consts.MAIN_PATH + "Mushrooms")
@onready var _cloud_list: = get_node(Consts.MAIN_PATH + "Clouds")

var _copy_from: = preload("res://Scenes/MapLoader/copy_from.tscn").instantiate()

const START_COPYING_AT: float = 300
const COPY_CHECK_DISTANCE_Y: float = 600
const DIVIDER_MARGIN: float = 50

@onready var _fairy: = get_node("../Fairy")

var next_load_point_y: float = START_COPYING_AT

func _process(_delta):
	_place_walls()
	_copy_maps()
	_clean_passed_entities()

func _clean_passed_entities() -> void:
	_clean_passed_entity_list(_coin_list, 10)
	_clean_passed_entity_list(_mushroom_list, 40)
	_clean_passed_entity_list(_cloud_list, 40)

func _clean_passed_entity_list(list: Node2D, keep: int) -> void:
	while list.get_child_count() > keep:
		list.remove_child(list.get_child(0))

func _place_walls() -> void:
	for i in range(floor(_fairy.position.y / 10) - 20, floor(_fairy.position.y / 10 )+ 20):
		if i <= 1: 
			continue
		set_cell(0, Vector2i(5, i), 0, Vector2i(0, 1))
		set_cell(0, Vector2i(44, i), 0, Vector2i(1, 1))

func _copy_maps() -> void:
	if not _should_load():
		return

	var divider_count: = _copy_from.get_node("Dividers").get_child_count()
	var choosen_divider: = randi_range(1, divider_count - 1)
	next_load_point_y += _copy(choosen_divider) + DIVIDER_MARGIN

func _copy(divider_num: int) -> float:
	var previous_divider: Node2D = _copy_from.get_node("Dividers/Divider" + str(divider_num - 1))
	var divider: Node2D = _copy_from.get_node("Dividers/Divider" + str(divider_num))

	var start_y = previous_divider.position.y / 10
	var end_y = divider.position.y / 10

	var copy_from_tile_map: TileMap = _copy_from.get_node("TileMap")

	for i in range(0, end_y - start_y):
		for x in range(5, 46):
			var y_from: int = i + start_y
			var y_to: int = i + floor(next_load_point_y / 10)

			var tile: = copy_from_tile_map.get_cell_atlas_coords(0, Vector2i(x, y_from))

			if tile == Vector2i(-1, -1):
				continue
				
			if tile == Vector2i(0, 2): # Coin
				var pos = Vector2(x * 10, y_to * 10 + 20)
				if GlobalFunctions.can_place_coin(pos):
					var coin = _coin_scene.instantiate()
					coin.position = pos
					GlobalFunctions.get_coin_list().add_child(coin)
				continue

			if tile == Vector2i(1, 2): # Mushroom
				var pos = Vector2(x * 10, y_to * 10 + 10)
				if GlobalFunctions.can_place_mushroom(pos):
					var mushroom = _mushroom_scene.instantiate()
					mushroom.position = pos
					GlobalFunctions.get_mushroom_list().add_child(mushroom)
				continue

			if tile == Vector2i(0, 3): # Cloud
				var pos = Vector2(x * 10, y_to * 10)
				if GlobalFunctions.can_place_cloud(pos):
					var cloud = _cloud_scene.instantiate()
					cloud.position = pos
					GlobalFunctions.get_cloud_list().add_child(cloud)
				continue

			self.set_cell(0, Vector2i(x, y_to), 0, tile)

	return divider.position.y - previous_divider.position.y

func _should_load() -> bool:
	if next_load_point_y - (GlobalFunctions.get_fairy_pos().y + COPY_CHECK_DISTANCE_Y) < 0:
		return true
	return false
