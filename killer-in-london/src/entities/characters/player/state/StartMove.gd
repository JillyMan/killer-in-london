extends State

var player : PlayerBase
var player_fsm : PlayerFSM

var step : float
var end_speed : float
var current_speed : float

var move_dir : Vector2

func fixed_tick(delta) -> void:
	move_dir = player.get_current_dir()
	if (move_dir == Vector2.ZERO):
		player_fsm.set_idle_state()

	var vel = move_dir * current_speed

	player.move_and_slide(vel)
	current_speed += step 

	if end_speed - current_speed < 0.1:
		player_fsm.set_moving_state()

	return

func enter(payload):
	player = host as PlayerBase
	player_fsm = fsm as PlayerFSM

	step = payload.step
	current_speed = payload.current_speed
	end_speed = payload.end_speed
	move_dir = payload.move_dir
	pass
