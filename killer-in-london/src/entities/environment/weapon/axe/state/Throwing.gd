extends State

const MIN_DISTANCE_BTW_AXE_AND_THROW_DEST = 20

var player : Node2D = null
var throwable_obj : KinematicBody2D = null

var target : Vector2
var move_dir : Vector2

var throw_len : float = 0.0

func fixed_tick(delta): 
	var v = throwable_obj.global_position - target
	var length_to_throw_dest = v.length()
	var friction = length_to_throw_dest / throw_len
	var linear_velocity = move_dir * host.throw_speed * friction
	var col = throwable_obj.move_and_collide(linear_velocity * delta, false, true, false)

	if (col != null or length_to_throw_dest < MIN_DISTANCE_BTW_AXE_AND_THROW_DEST):
		fsm.set_idle_state()
		return

	throwable_obj.rotate(delta * host.rotate_speed * friction)

func enter(payload):
	assert(host is KinematicBody2D)
	throwable_obj = host
	target = payload.target
	
	throw_len = (target - throwable_obj.global_position).length()
	move_dir = throwable_obj.global_position.direction_to(target)
	
	if throw_len > host.max_throw_distance:
		target = throwable_obj.global_position + move_dir*host.max_throw_distance
		throw_len = target.length()
