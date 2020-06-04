extends KinematicBody2D

class_name Axe

export var throw_speed : float = 1500
export var rotate_speed : float = 100

const MIN_DISTANCE_BTW_AXE_AND_THROW_DEST = 5

var move_dir : Vector2
var throw_destination_pos : Vector2

var throw_len : float = 0
var was_throwed : bool = false

signal end_of_throwing

func _physics_process(delta):
	if was_throwed:
		var length_to_throw_dest = (global_position - throw_destination_pos).length()
		var friction = length_to_throw_dest / throw_len
		var linear_velocity = move_dir * throw_speed * friction
		var col = move_and_collide(linear_velocity * delta, false, true, false)
		rotate(delta * rotate_speed * friction)

		if (col != null or length_to_throw_dest < MIN_DISTANCE_BTW_AXE_AND_THROW_DEST):
			was_throwed = false
			emit_signal("end_of_throwing")
	pass

func was_throwed() -> bool:
	return was_throwed

func throw(throw_goal : Vector2):
	throw_destination_pos = throw_goal
	var throw_vector = (throw_destination_pos - global_position)
	throw_len = throw_vector.length()
	move_dir = throw_vector.normalized()
	was_throwed = true
	pass

func comeback():
	pass

func _process(delta):
	pass
