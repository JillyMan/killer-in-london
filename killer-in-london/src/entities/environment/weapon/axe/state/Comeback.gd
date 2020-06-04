extends State

onready var idle_state = fsm.get_node("Idle")

const MIN_DISTANCE_BTW_AXE_AND_THROW_DEST = 5.0

export var comeback_throw_speed : float = 1500
export var comeback_rotate_speed : float = 100

var throwable_obj : KinematicBody2D
var comeback_to_node : Node2D
var throw_len : float

func fixed_tick(delta):
	var from_pos_to_target_v = comeback_to_node.global_position - throwable_obj.global_position
	var move_dir = from_pos_to_target_v.normalized()
	var length_to_throw_dest = from_pos_to_target_v.length()
	var friction = length_to_throw_dest / throw_len
	var linear_velocity = move_dir * comeback_throw_speed * friction

	throwable_obj.rotate(delta * comeback_rotate_speed * friction)
	var col = throwable_obj.move_and_collide(linear_velocity * delta, false, true, false)

	if (col != null or length_to_throw_dest < MIN_DISTANCE_BTW_AXE_AND_THROW_DEST):
		throwable_obj.emit_signal("on_weapon_returned")
		#mmmm, i don't know
		throwable_obj._weapon_returned()
		_next_state()

func _next_state():
	fsm.set_state(idle_state)

func enter(payload):
	assert(host is KinematicBody2D)
	throwable_obj = host
	comeback_to_node = payload.come_to
	throw_len = (throwable_obj.global_position - comeback_to_node.global_position).length()
