extends KinematicBody2D

var was_throwed : bool = false

export var throw_speed : float = 2000
export var rotate_speed : float = 100

export var comeback_speed : float = 100

signal on_weapon_returned
signal need_try_again

func was_throwed() -> bool:
	return was_throwed

func throw(target : Vector2):
	if not was_throwed:
		was_throwed = true
		$FSM.set_throwing_state(target)

func comeback(owner : Node2D):
	if was_throwed:
		$FSM.set_comback_state(owner)

func _weapon_returned():
	assert(was_throwed)
	was_throwed = false

func _process(delta):
	$FSM.handle_physic_process(delta)
	pass
