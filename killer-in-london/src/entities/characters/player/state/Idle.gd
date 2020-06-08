extends State

func tick(delta):
	if host.has_dir():
		fsm.set_moving_state()
	pass
