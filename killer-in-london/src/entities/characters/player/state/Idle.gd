extends State

func tick(delta):
	if host.has_dir():
		fsm.set_start_move_state(host.get_current_dir())
	pass
