extends KinematicBody2D

var was_throwed : bool = false

signal on_weapon_returned

func was_throwed() -> bool:
	return was_throwed

func throw(target : Vector2):
	if not was_throwed:
		was_throwed = true
		$FSM.set_state($FSM/Throwing, true, { 
			"target": target,
		})

func comeback(owner : Node2D):
	if was_throwed:
		$FSM.set_state($FSM/Comeback, true, { 
			"come_to": owner,
		})

func _weapon_returned():
	assert(was_throwed)
	was_throwed = false

func _process(delta):
	$FSM.handle_physic_process(delta)
	pass
