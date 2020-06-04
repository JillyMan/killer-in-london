class_name MoveToPoint
extends LeafTask


export var point_property_name := ""


func execute() -> int:
	var host = tree.host
	var point = host.get(point_property_name)
	
	if point == null:
		return self.Status.FAILED
	
	host.path_to_follow = get_tree().current_scene.pathfinder.calculate_path(host.global_position, point)
	
	if host.global_position.distance_to(point) < host.destination_radius:
		host.current_movement_target = null
		return self.Status.SUCCEEDED
	
	return self.Status.RUNNING


func end():
	var host = tree.host
	host.current_movement_target = null
	pass
