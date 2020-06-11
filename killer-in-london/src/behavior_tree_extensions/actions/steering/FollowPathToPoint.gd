class_name FollowPathToPoint
extends LeafTask


export var point_field_name := ""


func start():
	var host = tree.host
	
	if not host.get(point_field_name):
		return
	
	var pathfinder : AstarGridPathfinder  = get_tree().current_scene.pathfinder
	var path = pathfinder.calculate_path(host.global_position, host.get(point_field_name))
	host.set_path_to_follow(path)
	pass


func execute() -> int:
	var host = tree.host
	
#	if not host.get(point_field_name):
#		return self.Status.FAILED
#
#	host._steering += host.seek(host.get(point_field_name))
	
	if host.is_achieve_end_of_path():
		return self.Status.SUCCEEDED
		 
	host._steering += host.follow_path()
	return self.Status.RUNNING


func end():
	var host = tree.host
	host.set_path_to_follow([])
	pass

