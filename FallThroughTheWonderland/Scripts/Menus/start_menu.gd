extends Node2D

@onready var _menus = get_parent()

func _on_start_pressed():
	_menus.move_start_menu()

func _on_credits_pressed():
	GlobalFunctions.show_credits_menu()
