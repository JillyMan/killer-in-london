extends Node2D

export var subject_node_path : NodePath
onready var subject = get_node(subject_node_path) 


func _process(delta):
	if not Input.is_mouse_button_pressed(BUTTON_LEFT):
		return
	
	var pathfinder : AstarGridPathfinder = get_tree().current_scene.pathfinder
	var path = pathfinder.calculate_path(subject.global_position, get_global_mouse_position())

#	subject.set_path_to_follow(path)
	
	subject.movement_target_point = get_global_mouse_position()
	pass
