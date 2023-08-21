extends Area2D

@onready var _map: TileMap = get_node(Consts.MAIN_PATH + "TileMap")

const MOVE_SPEED: float = 50

var dir: Vector2

func _process(_delta):
	self.position += dir * MOVE_SPEED * _delta

func _on_body_entered(body):
	if body == _map:
		queue_free()
