extends Node2D

func _on_back_to_game_pressed():
	GlobalVars.showing_menus = false
	self.hide()

func _on_restart_pressed():
	GlobalVars.game_started = false
	
	GlobalVars.showing_menus = false
	self.hide()

func _on_credits_pressed():
	GlobalFunctions.show_credits_menu()
