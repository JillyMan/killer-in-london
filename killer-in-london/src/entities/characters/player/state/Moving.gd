extends State

var player_fsm : PlayerFSM
var player : PlayerBase

var last_dir : Vector2

func fixed_tick(delta):
	if (player.has_dir()):
		last_dir = player.get_current_dir()
		var vel = last_dir * player.speed
		player.move_and_slide(vel)
	else:
		player_fsm.set_idle_state()
		#player_fsm.set_end_move_state(player.speed, last_dir)
	pass

func enter(payload):
	player = host
	player_fsm = fsm as PlayerFSM
