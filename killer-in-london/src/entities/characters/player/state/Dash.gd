extends State

onready var player : PlayerBase

var time_accum : float
var dash_max_time_ : float
var move_dir : Vector2

func fixed_tick(delta):
	time_accum += delta
	player.move_and_slide(move_dir * player.dash_speed)
	if (time_accum > dash_max_time_):
		fsm.set_moving_state()
	pass

func enter(payload):
	player = host
	player.set_trail(true)
	time_accum = 0
	dash_max_time_ = player.dash_time_sec
	move_dir = player.get_move_dir()
	pass

func exit(payload):
	player.set_trail(false)
