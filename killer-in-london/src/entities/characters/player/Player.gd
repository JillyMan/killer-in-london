extends KinematicBody2D

export var speed: float = 100.0
export var dash_speed: float = 50.0
export var axe_scene : PackedScene

var axe : Axe

var last_mouse_pos : Vector2
var axe_throw_speed : float = 12
var time_to_throw_in_sec : float = 1

var with_axe : bool = true
var is_coming_axe : bool = false

func _ready():
	axe = axe_scene.instance()
	add_child(axe)
	axe.connect("end_of_throwing", self, "_axe_comeback")

func _axe_comeback():
	if not with_axe and is_coming_axe:
		get_tree().current_scene.remove_child(axe)
		add_child(axe)
		axe.position = Vector2.ZERO
		with_axe = true
		is_coming_axe = false

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

func throw_weapon(dest_point):
	with_axe = false
	var prev_pos = axe.global_position
	remove_child(axe)
	get_tree().current_scene.add_child(axe)
	axe.global_position = prev_pos
	axe.throw(dest_point)

func return_weapon():
	is_coming_axe = true
	axe.throw(global_position)

func _check_mouse(delta):
	var weapon_was_throwed = axe.was_throwed()

	if with_axe: 
		if Input.is_action_just_pressed("mouse_attack"):
			axe.rotate(PI/2)
		if Input.is_action_just_released("mouse_attack"):
			axe.rotate(-PI/2)

	var is_throw_weapon_pressed = Input.is_action_just_pressed("mouse_throw_weapon")
	if is_throw_weapon_pressed:
		if with_axe:
			throw_weapon(get_global_mouse_position())
		elif not is_coming_axe:
			return_weapon()
	pass

func _move_update(delta):
	_check_move()
	_check_mouse(delta)

func _process(delta):
	_move_update(delta)
	pass
