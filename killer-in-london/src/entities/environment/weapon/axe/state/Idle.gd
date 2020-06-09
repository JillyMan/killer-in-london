extends State

func enter(payload):
	print("entered")
	host.damage_producer_shape.set_deferred("disabled", true)

func exit(payload):
	print("exited")	
	host.damage_producer_shape.set_deferred("disabled", false)
