extends FSM

onready var idle_state = $Idle
onready var dash_state = $Dash
onready var moviong_state = $Moving
onready var start_move_state = $StartMove
onready var end_move_state = $StartEnd

func set_start_move_state(move_dir : Vector2):
	set_state(start_move_state, true, {
		"start_move_dir": move_dir
	})
	pass
	
func set_dash_state(move_dir : Vector2):
	set_state(dash_state, true, {
		"move_dir": move_dir
	})
	pass

func set_moving_state():
	set_state(moviong_state)
	pass

func set_end_move_state():
	set_state(idle_state)
#	set_state(end_move_state)
	pass

func set_idle_state():
	set_state(idle_state)
	pass
