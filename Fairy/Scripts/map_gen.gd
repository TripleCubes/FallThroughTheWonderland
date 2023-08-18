@tool
extends TileMap

@onready var _fairy: = get_node("../Fairy") 

func _process(_delta):
	for i in range(floor(_fairy.position.y / 10) - 20, floor(_fairy.position.y / 10 )+ 20):
		set_cell(0, Vector2i(5, i), 0, Vector2i(0, 0))
		set_cell(0, Vector2i(44, i), 0, Vector2i(0, 0))
