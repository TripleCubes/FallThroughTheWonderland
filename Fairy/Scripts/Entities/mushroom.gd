extends CharacterBody2D

const MOVE_SPEED: float = 1000

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
	
func _process(_delta):
	if _looking_left:
		velocity.x = - MOVE_SPEED * _delta
	else:
		velocity.x = MOVE_SPEED * _delta

	move_and_slide()

	if _should_turn():
		_looking_left = not _looking_left

func _should_turn() -> bool:
	return not _bottom_tile_solid() or is_on_wall()

func _bottom_tile_solid() -> bool:
	var check_pos: Vector2
	if _looking_left:
		check_pos = Vector2(global_position.x - 5, global_position.y + 2)
	else:
		check_pos = Vector2(global_position.x + 5, global_position.y + 2)
	
	if GlobalFunctions.is_solid_tile(check_pos):
		return true
	return false
