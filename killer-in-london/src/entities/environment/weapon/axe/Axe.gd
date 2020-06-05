extends KinematicBody2D

export var throw_speed : float = 2000
export var rotate_speed : float = 1000
export var comeback_speed : float = 2000

export var max_throw_distance : float = 100

signal on_weapon_returned
signal on_return_failed

func throw(target : Vector2):
	$FSM.set_throwing_state(target)

func comeback(owner : Node2D):
	$FSM.set_comback_state(owner)

func _weapon_returned():
	emit_signal("on_weapon_returned")

func _return_failed():
	emit_signal("on_return_failed")

func _process(delta):
	$FSM.handle_physic_process(delta)
	pass
