extends State

var player : PlayerBase
var player_fsm : PlayerFSM

var step : float
var end_speed : float
var current_speed : float
var move_dir : Vector2

func should_iterate() -> bool:
	if player.has_dir():
		player_fsm.set_moving_state()
		return false
	return true

func fixed_tick(delta) -> void:
	if not should_iterate():
		return

	var vel = move_dir * current_speed
	player.move_and_slide(vel)
	current_speed += step 

	if current_speed - end_speed < 0.1:
		fsm.set_idle_state()

	return

func enter(payload):
	player = host as PlayerBase
	player_fsm = fsm as PlayerFSM

	step = payload.step
	current_speed = payload.current_speed
	end_speed = payload.end_speed
	move_dir = payload.move_dir
	pass
