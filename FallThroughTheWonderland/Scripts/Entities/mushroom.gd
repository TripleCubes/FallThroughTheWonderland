extends CharacterBody2D

const MOVE_SPEED: float = 1000
const GRAVITY_ACCELERATION: float = 15000

var gravity: float = 0

var big_mushroom: = false:
	set(val):
		if big_mushroom == val:
			return
		
		big_mushroom = val

		if big_mushroom:
			var tween: = get_tree().create_tween()
			tween.tween_property(self, "scale", Vector2(2, 2), Consts.TWEEN_TIME_SEC).set_trans(Tween.TRANS_SINE)
		else:
			var tween: = get_tree().create_tween()
			tween.tween_property(self, "scale", Vector2(1, 1), Consts.TWEEN_TIME_SEC).set_trans(Tween.TRANS_SINE)

var _looking_left: = false:
	set(val):
		_looking_left = val
		
		if _looking_left:
			$Mushroom.flip_h = true
		else:
			$Mushroom.flip_h = false

func _ready():
	if randi_range(0, 1) == 1:
		_looking_left = true

	up_direction = Vector2(0, -1)

	_process_big_mushroom()

func _process(_delta):
	_process_big_mushroom()
	
func _physics_process(_delta):
	var vel: = Vector2(0, 0)

	if _looking_left:
		vel.x = - MOVE_SPEED * _delta
	else:
		vel.x = MOVE_SPEED * _delta

	if is_on_floor():
		gravity = 0

	gravity += GRAVITY_ACCELERATION * _delta

	vel += Vector2(0, gravity) * _delta

	velocity = vel
	move_and_slide()

	if _should_turn():
		_looking_left = not _looking_left

func _process_big_mushroom() -> void:
	if GlobalFunctions.get_effects_stats().get_duration(EffectNames.Names.BIG_MUSHROOM) > 0:
		big_mushroom = true
	else:
		big_mushroom = false

func _should_turn() -> bool:
	return not _bottom_tile_solid() or is_on_wall()

func _bottom_tile_solid() -> bool:
	var check_pos: Vector2
	if _looking_left:
		check_pos = Vector2(global_position.x - 5 * scale.x, global_position.y + 2)
	else:
		check_pos = Vector2(global_position.x + 5 * scale.x, global_position.y + 2)
	
	if GlobalFunctions.is_solid_tile(check_pos):
		return true
	return false
