extends State

var player : PlayerBase

var move_dir : Vector2

var start_speed : float = 0
var end_speed : float
var current_speed : float = 0
var step = 10

func fixed_tick(delta):
	var vel = move_dir * current_speed
	current_speed += step;
	player.move_and_slide(vel)
#	print(current_speed, " : ", end_speed, " ", current_speed >= end_speed)
	if end_speed - current_speed < 0.1:
		fsm.set_moving_state()
	pass

func enter(payload):
	player = host
	move_dir = payload.start_move_dir
	current_speed = start_speed
	end_speed = player.speed
	
