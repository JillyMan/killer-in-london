extends "res://src/libs/steering_behaviors/steered_actor/SteeredActor.gd"

export var enemy_node_path : NodePath 

var enemy_last_seen_position


onready var enemy = get_node(enemy_node_path)
onready var sign_ray_cast = $SignRayCast


func attack(direction):
	pass
