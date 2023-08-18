@tool
extends CharacterBody2D

const MOVE_SPEED: float = 4000
const GRAVITY_ACCELERATION: float = 15000
const SLOW_FALL_VELOCITY: float = 1000
const JUMP_VELOCITY: float = 8000

var gravity: float = 0

var slow_falling: = false:
	set(val):
		if slow_falling == val:
			return

		slow_falling = val
		
		if slow_falling:
			$Sprite/AnimatedSprite2D.hide()
			$Sprite/AnimatedSprite2DSlowFall.show()
		else:
			$Sprite/AnimatedSprite2D.show()
			$Sprite/AnimatedSprite2DSlowFall.hide()

func _ready():
	$Sprite/AnimatedSprite2D.play()
	$Sprite/AnimatedSprite2DSlowFall.play()

	up_direction = Vector2(0, -1)

func _draw():
	if Engine.is_editor_hint():
		return

	var mouse_pos: Vector2 = GlobalFunctions.get_local_mouse_pos(self)
	var dir_vec = (mouse_pos - $Sprite.position).normalized()

	draw_line($Sprite.position + dir_vec*10, mouse_pos + dir_vec*1000, Color(1, 1, 1))
	
func _process(_delta):
	$Sprite/AnimatedSprite2D.position.y = sin(float(Time.get_ticks_msec()) / 100) * 0.5
	$Sprite/AnimatedSprite2DSlowFall.position.y = sin(float(Time.get_ticks_msec()) / 100) * 0.5

	if Engine.is_editor_hint():
		return

	queue_redraw()

func _physics_process(_delta):
	if Engine.is_editor_hint():
		return

	if is_on_floor():
		gravity = 0

	var vel: = Vector2(0, 0)

	if Input.is_action_pressed("KEY_A"):
		vel += Vector2(-1, 0) * MOVE_SPEED * _delta
	if Input.is_action_pressed("KEY_D"):
		vel += Vector2(1, 0) * MOVE_SPEED * _delta
	if is_on_floor() and Input.is_action_pressed("KEY_SPACE"):
		gravity = - JUMP_VELOCITY

	gravity += GRAVITY_ACCELERATION * _delta

	if Input.is_action_pressed("KEY_SPACE") and gravity > 0:
		vel += Vector2(0, SLOW_FALL_VELOCITY) * _delta
		gravity = SLOW_FALL_VELOCITY
		slow_falling = true
	else:
		vel += Vector2(0, gravity) * _delta
		slow_falling = false

	velocity = vel
	move_and_slide()
