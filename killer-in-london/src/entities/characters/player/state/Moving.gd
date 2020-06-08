extends State

var player_fsm : PlayerFSM
var player : PlayerBase

var vel : Vector2

func fixed_tick(delta):
	vel += player.get_move_dir() * player.speed
	vel = lerp(vel, Vector2.ZERO, player.friction)
	player.move_and_slide(vel)
	pass

func enter(payload):
	vel = Vector2.ZERO
	player = host
	player_fsm = fsm as PlayerFSM
