extends Node2D

func _on_restart_pressed():
	GlobalVars.game_started = false

	GlobalVars.showing_menus = false
	self.hide()

func _process(_delta):
	var depth: int = round(GlobalFunctions.get_fairy_pos_center().y / 10)
	$Depth.text = str(depth) + "cm"
