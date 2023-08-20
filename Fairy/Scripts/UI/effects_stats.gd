extends Node2D

var _effect_node_list: = {}

func get_duration(effect_name: EffectNames.Names) -> float:
	var progress_bar: UI_ProgressBarHorizontal = _effect_node_list[effect_name].progress_bar
	return progress_bar.progress * progress_bar.reverse_fill_time_sec

func apply_effect(effect_name: EffectNames.Names) -> void:
	var effect_node = _effect_node_list[effect_name]
	effect_node.progress_bar.progress = 1
	
	if effect_node.visible: 
		return
		
	_put_effect_node_on_top_not_visible(effect_node)
	effect_node.visible = true

	var tween = get_tree().create_tween()
	tween.tween_property(effect_node.node, "position", Vector2(0, effect_node.node.position.y), 
							Consts.TWEEN_TIME_SEC).set_trans(Tween.TRANS_SINE)

func _ready():
	_effect_node_list[EffectNames.Names.AIM_SNAPPING] = {
		node = $AimSnap,
		progress_bar = $AimSnap/UI_ProgressBarHorizontal,
		visible = false,
	}

	_effect_node_list[EffectNames.Names.FLYING] = {
		node = $Fly,
		progress_bar = $Fly/UI_ProgressBarHorizontal,
		visible = false,
	}

	_effect_node_list[EffectNames.Names.LIGHT] = {
		node = $Light,
		progress_bar = $Light/UI_ProgressBarHorizontal,
		visible = false,
	}

func _process(_delta):
	for effect_node in _effect_node_list.values():
		if not (effect_node.visible and effect_node.progress_bar.progress == 0):
			continue

		effect_node.visible = false
		var tween = get_tree().create_tween()
		tween.tween_property(effect_node.node, "position", Vector2(-100, effect_node.node.position.y), 
								Consts.TWEEN_TIME_SEC).set_trans(Tween.TRANS_SINE)
		var timer = get_tree().create_timer(Consts.TWEEN_TIME_SEC)
		timer.timeout.connect(_rearrange_effect_nodes)

func _rearrange_effect_nodes() -> void:
	var cursor_y: float = 0

	for effect_node in _effect_node_list.values():
		if not effect_node.visible:
			continue

		var tween = get_tree().create_tween()
		tween.tween_property(effect_node.node, "position", Vector2(effect_node.node.position.x, cursor_y), 
								Consts.TWEEN_TIME_SEC).set_trans(Tween.TRANS_SINE)
		cursor_y += 19

	for effect_node in _effect_node_list.values():
		if effect_node.visible:
			continue

		var tween = get_tree().create_tween()
		tween.tween_property(effect_node.node, "position", Vector2(effect_node.node.position.x, cursor_y), 
								Consts.TWEEN_TIME_SEC).set_trans(Tween.TRANS_SINE)
		cursor_y += 19

func _put_effect_node_on_top_not_visible(effect_node: Dictionary) -> void:
	var cursor_y: float = 0

	for effect_node_comp in _effect_node_list.values():
		if not effect_node_comp.visible:
			continue

		cursor_y += 19

	effect_node.node.position.y = cursor_y
	cursor_y += 19

	for effect_node_comp in _effect_node_list.values():
		if effect_node_comp.visible:
			continue

		if effect_node_comp == effect_node:
			continue
		
		effect_node_comp.node.position.y = cursor_y
		cursor_y += 19
