extends Node2D

func _ready():
	Input.set_custom_mouse_cursor(preload("res://Assets/Sprites/target_pointer.png"), Input.CURSOR_ARROW,
									Vector2(18, 18))

func _process(_delta):
	if Input.is_action_just_pressed("KEY_1"):
		GlobalVars.game_started = false
