extends State

var player : PlayerBase

func fixed_tick(delta):
	if (player.has_dir()):
		var vel = player.get_current_dir() * player.speed
		player.move_and_slide(vel)
	else:
		fsm.set_end_move_state()
	pass

func enter(payload):
	player = host
