extends State

const MIN_DISTANCE_BTW_AXE_AND_THROW_DEST = 20.0

var throwable_obj : Axe
var comeback_to_node : Node2D
var throw_len : float

func fixed_tick(delta) -> void:
	var from_pos_to_target_v = comeback_to_node.global_position - throwable_obj.global_position
	var length_to_throw_dest = from_pos_to_target_v.length()
	var move_dir = from_pos_to_target_v.normalized()

	var friction = (length_to_throw_dest / throw_len)
	var linear_velocity = move_dir * host.comeback_speed * friction

	var col = throwable_obj.move_and_collide(linear_velocity * delta, false, true, false)
	if col != null:
		#_soft_return()
		return
	if length_to_throw_dest < MIN_DISTANCE_BTW_AXE_AND_THROW_DEST:
		_hard_return()
		return

	throwable_obj.rotate(delta * host.rotate_speed * friction)
	return

func _soft_return():
	fsm.set_idle_state()
	host._return_failed()

func _hard_return() -> void:
	fsm.set_idle_state()
	throwable_obj._weapon_returned()
	return

func enter(payload):
	assert(host is Axe)
	throwable_obj = host as Axe
	throwable_obj._set_collision(false)
	comeback_to_node = payload.come_to
	throw_len = (throwable_obj.global_position - comeback_to_node.global_position).length()

func exit(_payload):
	throwable_obj._set_collision(true)
	
