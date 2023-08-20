@tool
extends Node2D

const _heart_texture: = preload("res://Assets/Sprites/heart.png")

var health_count: int = 3:
	set(val):
		health_count = val
		queue_redraw()

func _draw():
	for i in health_count:
		draw_texture(_heart_texture, Vector2(i * (_heart_texture.get_width() + 4), 0))
