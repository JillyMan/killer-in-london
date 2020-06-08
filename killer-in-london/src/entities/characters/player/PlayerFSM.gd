class_name PlayerFSM
extends FSM

onready var dash_state = $Dash
onready var moving_state = $Moving

func set_dash_state():
	set_state(dash_state)
	pass

func set_moving_state():
	set_state(moving_state)
	pass
