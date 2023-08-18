extends RigidBody2D

func _on_area_2d_area_entered(area):
	if area == GlobalFunctions.get_fairy().area:
		queue_free()
