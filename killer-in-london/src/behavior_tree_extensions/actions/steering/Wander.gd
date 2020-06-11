class_name Wander
extends LeafTask


func execute() -> int:
	var host = tree.host
	host._steering += host.wander()
	host._steering += host.collision_avoidance()
	return self.Status.RUNNING
