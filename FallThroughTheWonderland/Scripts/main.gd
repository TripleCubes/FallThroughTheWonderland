extends Node2D

func _ready():
	Input.set_custom_mouse_cursor(preload("res://Assets/Sprites/target_pointer.png"), Input.CURSOR_ARROW,
									Vector2(18, 18))

func _process(_delta):
	if GlobalVars.intro_shown and Input.is_action_just_pressed("KEY_ESC"):
		GlobalFunctions.toggle_pause_menu()
