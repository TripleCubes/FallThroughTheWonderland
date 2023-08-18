extends Node2D

@onready var original_pos = self.position - GlobalFunctions.get_cam_pos()

func _process(_delta):
	var camera_pos: = GlobalFunctions.get_cam_pos()
	self.position = original_pos + camera_pos
