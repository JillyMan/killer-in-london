extends State

const MIN_DISTANCE_BTW_AXE_AND_THROW_DEST = 5

var player : Node2D = null
var throwable_obj : KinematicBody2D = null

var target : Vector2
var move_dir : Vector2

var was_throwed : bool = false
var throw_len : float = 0.0

func fixed_tick(delta): 
	var length_to_throw_dest = (throwable_obj.global_position - target).length()
	var friction = length_to_throw_dest / throw_len
	var linear_velocity = move_dir * host.throw_speed * friction
	var col = throwable_obj.move_and_collide(linear_velocity * delta, false, true, false)
	throwable_obj.rotate(delta * host.rotate_speed * friction)

	if (col != null or length_to_throw_dest < MIN_DISTANCE_BTW_AXE_AND_THROW_DEST):
		was_throwed = false
		fsm.set_idle_state()

func enter(payload):
	assert(host is KinematicBody2D)

	throwable_obj = host
	target = payload.target
	
	move_dir = (target - throwable_obj.global_position).normalized()
	throw_len = (target - throwable_obj.global_position).length()
