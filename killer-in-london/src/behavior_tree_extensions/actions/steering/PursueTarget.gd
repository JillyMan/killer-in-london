class_name PursueTarget
extends LeafTask


export var target_field_name := ""


func execute() -> int:
	var host = tree.host
	host._steering += host.pursuit(host.get(target_field_name))
	return self.Status.RUNNING
