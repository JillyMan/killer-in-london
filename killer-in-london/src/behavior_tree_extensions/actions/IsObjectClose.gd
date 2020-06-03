class_name IsObjectClose
extends GuardDecorator

export var distance : = 0.0
export var object_field_name := ""


func check_condition() -> bool:
	var host = tree.host
	var object = host.get(object_field_name)
	
	return host.global_position.distance_to(object.global_position) < distance
