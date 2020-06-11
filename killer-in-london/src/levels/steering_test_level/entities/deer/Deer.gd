extends "res://src/libs/steering_behaviors/steered_actor/SteeredActor.gd"

export var hunter_node_path : NodePath

onready var hunter = get_node(hunter_node_path)
onready var sign_ray_cast = $SignRayCast

var enemy_last_seen_position


func _apply_behavior():
	$BehaviorTree.step()
#	if global_position.distance_to(hunter.global_position) < 64:
#		_steering += evade(hunter)
#	else:
#		_steering += wander()
	
#	_steering += pursuit(hunter)
#	_steering += collision_avoidance()
	pass
