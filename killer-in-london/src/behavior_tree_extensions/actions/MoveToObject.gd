tool
class_name MoveToObject
extends LeafTask

export var object_property_name := ""


func execute() -> int:
	var host = tree.host
	var object = host.get(object_property_name)
	
	host.path_to_follow = get_tree().current_scene.pathfinder.calculate_path(host.global_position, object.global_position)
	
	if host.get_distance_to_current_movement_target() < host.destination_radius:
		host.current_movement_target = null
		return self.Status.SUCCEEDED
	
	return self.Status.RUNNING
