extends KinematicBody2D

onready var axe = get_node("Axe")

export var speed: float = 100.0
export var dash_speed: float = 50.0

var last_mouse_pos : Vector2
var axe_throw_speed : float = 12
var is_weapon_throwed : bool = false
var time_to_throw_in_sec : float = 1

var with_axe : bool = true

func _get_velocity_by_input() -> Vector2:
	var v = Vector2.ZERO
	
	if Input.is_action_pressed("player_move_up"):
		v.y = -1
	if Input.is_action_pressed("player_move_down"):
		v.y = 1
	if Input.is_action_pressed("player_move_left"):
		$Sprite.set_flip_h(true)
		v.x = -1
	if Input.is_action_pressed("player_move_right"):
		$Sprite.set_flip_h(false)
		v.x = 1

	return v.normalized()

func _check_move():
	var v = _get_velocity_by_input()
	move_and_slide(v * speed)

	if Input.is_action_just_pressed("player_dash"):
		speed += 400

func _animate_axe_throwing(delta) -> void:
	var length_btw_axe_and_mouse_pos = (axe.position - last_mouse_pos).length()
	if length_btw_axe_and_mouse_pos < 0.5:
		is_weapon_throwed = false
		return

	axe.position = axe.position.linear_interpolate(last_mouse_pos, delta * axe_throw_speed)
	axe.rotate(delta * length_btw_axe_and_mouse_pos)

	return

func _animate_axe_comeback(delta) -> void:
	var len_btw_playar_and_axe = (axe.position - position).length()
	if (len_btw_playar_and_axe < 0.5):
		with_axe = false
		return

	axe.position = axe.position.linear_interpolate(position, delta * axe_throw_speed)
	axe.rotate(-delta * len_btw_playar_and_axe)
	return

func _check_mouse(delta):
	if Input.is_action_just_pressed("mouse_attack"):
		axe.rotate(-PI/2)
	if Input.is_action_just_released("mouse_attack"):
		axe.rotate(PI/2)

	var is_throw_weapon_pressed = Input.is_action_just_pressed("mouse_throw_weapon")

	if with_axe and is_throw_weapon_pressed:
		is_weapon_throwed = true
		with_axe = false
		last_mouse_pos = get_local_mouse_position()

	if not with_axe and is_weapon_throwed:
		_animate_axe_throwing(delta)

	if is_throw_weapon_pressed and not with_axe:
		_animate_axe_comeback(delta)

func _move_update(delta):
	_check_move()
	_check_mouse(delta)

func _process(delta):
	_move_update(delta)
	pass
