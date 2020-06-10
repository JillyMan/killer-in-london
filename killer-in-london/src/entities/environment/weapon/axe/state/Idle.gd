extends State

func enter(payload):
	host.damage_producer_shape.set_deferred("disabled", true)

func exit(payload):
	host.damage_producer_shape.set_deferred("disabled", false)
