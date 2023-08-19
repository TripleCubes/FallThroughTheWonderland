extends Node2D

const ICON_WIDTH_PLUS_SPACING_PX: float = 20

var effect_list_1: = []
var effect_list_0: = []

func flipped(result: int) -> void:
	if result == 1:
		_put_to_one_list(effect_list_1, effect_list_0)
	else:
		_put_to_one_list(effect_list_0, effect_list_1)

func _ready():
	_new_lists(4)

func _put_to_one_list(from: Array, to: Array) -> void:
	for effect in to:
		effect.sprite.queue_free()
	to.clear()

	var from_original_size: int = from.size()
	for i in floor(float(from_original_size) / 2):
		var index: int = from_original_size - i - 1

		to.append(from[index])
		from.remove_at(index)

	to.reverse()

	for i in effect_list_1.size():
		var tween = get_tree().create_tween()
		tween.tween_property(effect_list_1[i].sprite, "position", 
								Vector2(i * ICON_WIDTH_PLUS_SPACING_PX, $IconSprites/Pos1.position.y), 
								Consts.TWEEN_TIME).set_trans(Tween.TRANS_SINE)

	for i in effect_list_0.size():
		var tween = get_tree().create_tween()
		tween.tween_property(effect_list_0[i].sprite, "position", 
								Vector2(i * ICON_WIDTH_PLUS_SPACING_PX, $IconSprites/Pos0.position.y), 
								Consts.TWEEN_TIME).set_trans(Tween.TRANS_SINE)

func _new_lists(num_effects_one_list: int) -> void:
	_new_list(num_effects_one_list, 1)
	_new_list(num_effects_one_list, 0)

func _new_list(num_effects: int, list_num: int) -> void:
	var list: Array
	if list_num == 0:
		list = effect_list_0
	else:
		list = effect_list_1

	for effect in list:
		effect.sprite.queue_free()
	list.clear()

	for i in num_effects:
		var effect_name: = randi_range(0, EffectNames.Names.size() - 1)
		
		var sprite = Sprite2D.new()
		sprite.texture = EffectNames.texture_list[effect_name]
		sprite.centered = false
		sprite.position.x = i * ICON_WIDTH_PLUS_SPACING_PX
		if list_num == 0:
			sprite.position.y = $IconSprites/Pos0.position.y
		else:
			sprite.position.y = $IconSprites/Pos1.position.y
		
		$IconSprites.add_child(sprite)

		list.append({
			effect_name = effect_name,
			sprite = sprite,
		})
