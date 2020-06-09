class_name Player
extends PlayerBase

export var throw_kd : float = 0

onready var kd_timer = $KdTimer
onready var weapon_position = $AnimationTransorm/WeaponPosition
onready var axe = $AnimationTransorm/WeaponPosition/Axe
onready var start_transform = axe.transform
onready var animation_player = $AnimationTransorm/AnimationPlayer

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
	with_axe = true
	is_coming_axe = false
	print(throw_kd)
	kd_timer.start(throw_kd)
	pass

func _check_mouse():
	if with_axe: 
		if Input.is_action_just_pressed("mouse_attack"):
			axe.rotate(PI/2)
		if Input.is_action_just_released("mouse_attack"):
			axe.rotate(-PI/2)

	if Input.is_action_just_pressed("mouse_throw_weapon"):
		if with_axe:
			if kd_timer.time_left == 0:
				_throw_weapon(get_global_mouse_position())
		elif not is_coming_axe:
			_return_weapon()
	pass

func _update_animation():
	var mouse_pos = get_global_mouse_position()
	var dir = (mouse_pos - global_position).normalized()
	if dir.x > 0:
		$AnimationTransorm.scale.x = 1
	else:
		$AnimationTransorm.scale.x = -1

func _process(delta):
	update_move_dir()

	if Input.is_action_just_pressed("player_dash"):
		$FSM.set_dash_state()

	$FSM.handle_physic_process(delta)
	_check_mouse()
	_update_animation()
	pass
