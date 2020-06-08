extends "res://src/libs/steering_behaviors/steered_actor/SteeredActor.gd"


export var prey_node_path : NodePath

onready var prey = get_node(prey_node_path)

var movement_target_point


func _apply_behavior():
	if movement_target_point:
		_steering += seek(movement_target_point)
		_steering += collision_avoidance()
	pass
