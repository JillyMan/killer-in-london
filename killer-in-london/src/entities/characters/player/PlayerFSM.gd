class_name PlayerFSM
extends FSM

onready var idle_state = $Idle
onready var dash_state = $Dash
onready var moving_state = $Moving
onready var start_move_state = $StartMove
onready var end_move_state = $EndMove

func set_start_move_state(move_dir : Vector2):
	set_state(start_move_state, true, {
		"step": 5,
		"end_speed": 200,
		"current_speed": 0,
		"move_dir": move_dir,
	})
	pass

func set_end_move_state(current_speed : float, move_dir : Vector2):
	set_state(end_move_state, true, {
		"step": -10,
		"end_speed": 0,
		"current_speed": current_speed,
		"move_dir": move_dir,
	})
	pass

func set_dash_state(move_dir : Vector2):
	set_state(dash_state, true, {
		"move_dir": move_dir
	})
	pass

func set_moving_state():
	set_state(moving_state)
	pass

func set_idle_state():
	set_state(idle_state)
	pass
