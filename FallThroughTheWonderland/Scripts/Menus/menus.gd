extends Node2D

func move_start_menu() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($StartMenu, "position", Vector2(-500, 0), 1.2).set_trans(Tween.TRANS_SINE)

	GlobalVars.showing_menus = false

	GlobalFunctions.show_fade(GlobalFunctions.get_tutorial().move, 3, 0.5, 7)
	GlobalFunctions.show_fade(GlobalFunctions.get_tutorial().slow_fall, 13, 0.5, 7)
	GlobalFunctions.show_fade(GlobalFunctions.get_tutorial().throw_coin, 23, 0.5, 7)
