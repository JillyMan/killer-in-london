extends KinematicBody2D

export var speed: float = 100.0
export var dash_speed: float = 50.0

onready var axe = $AnimationTransorm/WeaponPosition/Axe
onready var start_transform = axe.transform
onready var weapon_position = $AnimationTransorm/WeaponPosition

var with_axe : bool = true
var is_coming_axe : bool = false

func _ready():
	axe.connect("on_weapon_returned", self, "_on_weapon_returned")
	axe.connect("on_return_failed", self,  "_on_try_return_weapon_failed")

func _attach_weapon(weapon):
	get_tree().current_scene.remove_child(weapon)
	weapon_position.add_child(weapon)
	weapon.transform = start_transform
	pass

func _detach_weapon(weapon):
	var prev_pos = weapon.global_position
	weapon_position.remove_child(weapon)
	get_tree().current_scene.add_child(weapon)
	weapon.global_position = prev_pos
	pass

func _throw_weapon(dest_point):
	with_axe = false
	_detach_weapon(axe)
	axe.throw(dest_point)

func _return_weapon():
	assert(not with_axe and not is_coming_axe)
	is_coming_axe = true
	axe.comeback(weapon_position)

func _on_try_return_weapon_failed():
	assert(is_coming_axe)
	is_coming_axe = false

func _on_weapon_returned():
	assert(not with_axe and is_coming_axe)
	_attach_weapon(axe)
	is_coming_axe = false
	with_axe = true
	pass

func _check_mouse(delta):
	if with_axe: 
		if Input.is_action_just_pressed("mouse_attack"):
			axe.rotate(PI/2)
		if Input.is_action_just_released("mouse_attack"):
			axe.rotate(-PI/2)

	if Input.is_action_just_pressed("mouse_throw_weapon"):
		if with_axe:
			_throw_weapon(get_global_mouse_position())
		elif not is_coming_axe:
			_return_weapon()
	pass

func _get_velocity_by_input() -> Vector2:
	var v = Vector2.ZERO
	if Input.is_action_pressed("player_move_up"):
		v.y = -1
	if Input.is_action_pressed("player_move_down"):
		v.y = 1
	if Input.is_action_pressed("player_move_left"):
		v.x = -1
		$AnimationTransorm.scale.x = -1
	if Input.is_action_pressed("player_move_right"):
		$AnimationTransorm.scale.x = 1
		v.x = 1

	return v.normalized()

func _update_animation():
	var mouse_pos = get_global_mouse_position()
	var dir = (mouse_pos - global_position).normalized()
	if dir.x > 0:
		$AnimationTransorm.scale.x = 1
	else:
		$AnimationTransorm.scale.x = -1

func _update_move():
	var v = _get_velocity_by_input()
	move_and_slide(v * speed)
	if Input.is_action_just_pressed("player_dash"):
		speed += 400

func _move_update(delta):
	_update_move()
	_check_mouse(delta)
	_update_animation()

func _process(delta):
	_move_update(delta)
	pass
