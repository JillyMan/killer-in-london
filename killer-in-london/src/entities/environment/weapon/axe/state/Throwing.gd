extends State

const MIN_DISTANCE_BTW_AXE_AND_THROW_DEST = 5

export var throw_speed : float = 1500
export var rotate_speed : float = 100

onready var idle_state = fsm.get_node("Idle")

var player : Node2D = null
var throwable_obj : KinematicBody2D = null

var target : Vector2
var move_dir : Vector2

var was_throwed : bool = false
var throw_len : float = 0.0

func fixed_tick(delta): 
	var length_to_throw_dest = (throwable_obj.global_position - target).length()
	var friction = length_to_throw_dest / throw_len
	var linear_velocity = move_dir * throw_speed * friction
	var col = throwable_obj.move_and_collide(linear_velocity * delta, false, true, false)
	throwable_obj.rotate(delta * rotate_speed * friction)

	if (col != null or length_to_throw_dest < MIN_DISTANCE_BTW_AXE_AND_THROW_DEST):
		was_throwed = false
		fsm.set_state(idle_state)

func enter(payload):
	assert(host is KinematicBody2D)

	throwable_obj = host
	target = payload.target
	
	move_dir = (target - throwable_obj.global_position).normalized()
	throw_len = (target - throwable_obj.global_position).length()
