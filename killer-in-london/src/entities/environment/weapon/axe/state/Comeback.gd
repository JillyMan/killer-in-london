extends State

const MIN_DISTANCE_BTW_AXE_AND_THROW_DEST = 5.0

var throwable_obj : KinematicBody2D
var comeback_to_node : Node2D
var throw_len : float

func fixed_tick(delta):
	var from_pos_to_target_v = comeback_to_node.global_position - throwable_obj.global_position
	var move_dir = from_pos_to_target_v.normalized()
	var length_to_throw_dest = from_pos_to_target_v.length()
	var friction = (length_to_throw_dest / throw_len)
	var linear_velocity = move_dir * host.comeback_speed * (1 / friction)

	throwable_obj.rotate(delta * -host.rotate_speed * friction)
	var col = throwable_obj.move_and_collide(linear_velocity * delta, false, true, false)

	if col != null:
		_soft_return(col.collider)
	elif length_to_throw_dest < MIN_DISTANCE_BTW_AXE_AND_THROW_DEST:
		_hard_return()

func _soft_return(collider):
	if collider.get_instance_id() == comeback_to_node.get_instance_id():
		_hard_return()
	else:
		host.emit_signal()
		fsm.set_idle_state()

func _hard_return():
		fsm.set_idle_state()
		throwable_obj._weapon_returned()
		throwable_obj.emit_signal("on_weapon_returned")

func enter(payload):
	assert(host is KinematicBody2D)
	throwable_obj = host
	comeback_to_node = payload.come_to
	throw_len = (throwable_obj.global_position - comeback_to_node.global_position).length()
