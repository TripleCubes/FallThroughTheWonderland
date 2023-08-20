extends Node2D

const ICON_WIDTH_PLUS_SPACING_PX: float = 20

var effect_list_1: = []
var effect_list_0: = []

func flipped(result: int) -> void:
	if effect_list_0.size() == 1 and effect_list_1.size() == 1:
		if result == 1:
			GlobalFunctions.get_effects_stats().apply_effect(effect_list_1[0].effect_name)
		else:
			GlobalFunctions.get_effects_stats().apply_effect(effect_list_0[0].effect_name)

		var timer = get_tree().create_timer(2)
		timer.timeout.connect(func():
			_new_lists(1)
		)

	if result == 1:
		$Boxes/Box1.start_flick()
		_put_to_one_list(effect_list_1, effect_list_0)
	else:
		$Boxes/Box0.start_flick()
		_put_to_one_list(effect_list_0, effect_list_1)

func _ready():
	_new_lists(1)

func _put_to_one_list(from: Array, to: Array) -> void:
	for i in to.size():
		var effect = to[i]
		_queue_free_animation(effect.sprite, i * 0.15)
	to.clear()

	var from_original_size: int = from.size()
	for i in floor(float(from_original_size) / 2):
		var index: int = from_original_size - i - 1

		to.append(from[index])
		from.remove_at(index)

	to.reverse()

	var timer: = get_tree().create_timer(2)
	timer.timeout.connect(func():
		for i in effect_list_1.size():
			var tween = get_tree().create_tween()
			tween.tween_property(effect_list_1[i].sprite, "position", 
									Vector2(i * ICON_WIDTH_PLUS_SPACING_PX, $IconSprites/Pos1.position.y), 
									Consts.TWEEN_TIME_SEC).set_trans(Tween.TRANS_SINE)

		for i in effect_list_0.size():
			var tween = get_tree().create_tween()
			tween.tween_property(effect_list_0[i].sprite, "position", 
									Vector2(i * ICON_WIDTH_PLUS_SPACING_PX, $IconSprites/Pos0.position.y), 
									Consts.TWEEN_TIME_SEC).set_trans(Tween.TRANS_SINE)
	)

func _queue_free_animation(sprite: Node2D, wait: float) -> void:
	var timer_0 = get_tree().create_timer(wait)
	timer_0.timeout.connect(func():
		var tween_0 = get_tree().create_tween()
		tween_0.tween_property(sprite, "position", Vector2(sprite.position.x, sprite.position.y - 80), 
								1).set_trans(Tween.TRANS_SINE)
	)

	var timer_1 = get_tree().create_timer(wait + 3)
	timer_1.timeout.connect(func():
		sprite.queue_free()
	)

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
		_queue_free_animation(effect.sprite, 0)
	list.clear()

	for i in num_effects:
		var effect_name: = randi_range(0, EffectNames.Names.size() - 1)
		
		var sprite = Sprite2D.new()
		sprite.texture = EffectNames.texture_list[effect_name]
		sprite.centered = false
		sprite.position.x = i * ICON_WIDTH_PLUS_SPACING_PX
		if list_num == 0:
			_new_sprite_animation(sprite, $IconSprites/Pos0.position.y)
		else:
			_new_sprite_animation(sprite, $IconSprites/Pos1.position.y)
		
		$IconSprites.add_child(sprite)

		list.append({
			effect_name = effect_name,
			sprite = sprite,
		})

func _new_sprite_animation(sprite: Sprite2D, y: float) -> void:
	sprite.position.y = y - 120

	var timer: = get_tree().create_timer(0.2)
	timer.timeout.connect(func():
		var tween = get_tree().create_tween()
		tween.tween_property(sprite, "position", Vector2(sprite.position.x, y), 1).set_trans(Tween.TRANS_SINE)
	)
