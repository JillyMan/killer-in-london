class_name SmoothMove
extends State

var player : PlayerBase
var player_fsm : PlayerFSM

var step : float
var end_speed : float
var current_speed : float

var move_dir : Vector2

func enter(payload):
	player = host as PlayerBase
	player_fsm = fsm as PlayerFSM

	step = payload.step
	current_speed = payload.current_speed
	end_speed = payload.end_speed
	move_dir = payload.move_dir
	pass
