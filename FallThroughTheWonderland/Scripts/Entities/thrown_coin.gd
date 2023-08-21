extends Area2D

@onready var _map: TileMap = get_node(Consts.MAIN_PATH + "TileMap")
@onready var _mushroom_list = get_node(Consts.MAIN_PATH + "Mushrooms")
@onready var _cloud_list = get_node(Consts.MAIN_PATH + "Clouds")

const MOVE_SPEED: float = 200

var dir: Vector2

func _process(_delta):
	self.position += dir * MOVE_SPEED * _delta

func _on_body_entered(body):
	if body == _map:
		queue_free()

	if body.get_parent() == _mushroom_list:
		body.queue_free()
		queue_free()

	if body.get_parent() == _cloud_list:
		body.queue_free()
		queue_free()
