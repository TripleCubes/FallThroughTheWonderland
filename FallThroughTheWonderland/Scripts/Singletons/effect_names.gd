extends Node

enum Names {
	LIGHT,
	AIM_SNAPPING,
	FLYING,
}

var texture_list: = {}
var effect_singleton_list: = {}

func _ready():
	texture_list[Names.LIGHT] = preload("res://Assets/Sprites/Effects/light.png")
	texture_list[Names.AIM_SNAPPING] = preload("res://Assets/Sprites/Effects/aim_snap.png")
	texture_list[Names.FLYING] = preload("res://Assets/Sprites/Effects/fly.png")
