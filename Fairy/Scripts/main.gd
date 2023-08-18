extends Node2D

func _ready():
	Input.set_custom_mouse_cursor(preload("res://Assets/Sprites/target_pointer.png"), Input.CURSOR_ARROW,
									Vector2(18, 18))
