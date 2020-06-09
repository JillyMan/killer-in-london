extends "res://src/libs/steering_behaviors/steered_actor/SteeredActor.gd"


var movement_target_point


func _apply_behavior():
	if movement_target_point:
		_steering += seek(movement_target_point)
#		_steering += collision_avoidance()
	pass


func _calculate_dir():
	pass
