extends State

var player : PlayerBase

var move_dir : Vector2

var step = 20
var end_speed : float = 0
var current_speed : float = 0

func fixed_tick(delta):
	move_dir = player.get_current_dir()
	var vel = move_dir * current_speed
	current_speed -= step;
	player.move_and_slide(vel)
	#print(current_speed)
	if current_speed - end_speed < 0.1:
		fsm.set_idle_state()
	pass

func enter(payload):
	player = host
	current_speed = player.speed
	move_dir = payload.move_dir
