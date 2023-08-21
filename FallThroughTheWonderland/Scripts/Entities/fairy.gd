@tool
extends CharacterBody2D

const _thrown_coin_scene: PackedScene = preload("res://Scenes/Entities/thrown_coin.tscn")
@onready var _thrown_coin_list: = get_node(Consts.MAIN_PATH + "ThrownCoins")

@onready var _mushroom_list = get_node(Consts.MAIN_PATH + "Mushrooms")
@onready var _cloud_list = get_node(Consts.MAIN_PATH + "Clouds")
@onready var _rain_list = get_node(Consts.MAIN_PATH + "Rains")

const MOVE_SPEED: float = 4000
const GRAVITY_ACCELERATION: float = 15000
const SLOW_FALL_VELOCITY: float = 1000
const FLY_VELOCITY: float = -3000
const JUMP_VELOCITY: float = 8000

var gravity: float = 0

@onready var area = $Area2D

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

func take_damage() -> void:
	if $Sprite/FairyCenter.flicking:
		return

	$Sprite/FairyCenter.start_flick()
	GlobalFunctions.get_stats().health_count -= 1

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
	$Sprite/FairyCenter.position.y = sin(float(Time.get_ticks_msec()) / 100) * 0.5

	if Engine.is_editor_hint():
		return

	_throw_coin_process()

	if self.position.x > 250 + 1000:
		self.position.x = 250 + 1000
	elif self.position.x < 250 - 1000:
		self.position.x = 250 - 1000

	_set_camera_pos()

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
	if is_on_floor() and Input.is_action_just_pressed("KEY_SPACE"):
		gravity = - JUMP_VELOCITY

	gravity += GRAVITY_ACCELERATION * _delta

	if Input.is_action_pressed("KEY_SPACE") and gravity > 0:
		vel += Vector2(0, SLOW_FALL_VELOCITY) * _delta
		gravity = SLOW_FALL_VELOCITY
		slow_falling = true
	else:
		vel += Vector2(0, gravity) * _delta
		slow_falling = false

	if Input.is_action_pressed("KEY_SPACE") \
	and GlobalFunctions.get_effects_stats().get_duration(EffectNames.Names.FLYING) > 0:
		vel.y = FLY_VELOCITY * _delta
		gravity = FLY_VELOCITY
		slow_falling = true

	velocity = vel
	move_and_slide()

func _set_camera_pos() -> void:
	if not GlobalVars.game_started:
		$Camera2D.position.x = 0
		return

	$Camera2D.global_position.x = 250

func _on_area_2d_body_entered(body):
	if body.get_parent() == _mushroom_list \
	or body.get_parent() == _cloud_list:
		take_damage()

func _on_area_2d_area_entered(in_area):
	if in_area.get_parent() == _rain_list:
		take_damage()
		in_area.queue_free()

func _throw_coin_process() -> void:
	if Input.is_action_just_pressed("MOUSE_LEFT") and GlobalFunctions.get_stats().coin_count > 0:
		GlobalFunctions.get_stats().coin_count -= 1
		var thrown_coin = _thrown_coin_scene.instantiate()
		var mouse_pos: Vector2 = GlobalFunctions.get_local_mouse_pos(self)
		thrown_coin.dir = (mouse_pos - $Sprite.position).normalized()
		thrown_coin.global_position = $Sprite.global_position
		_thrown_coin_list.add_child(thrown_coin)
