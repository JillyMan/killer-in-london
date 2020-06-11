class_name Attack
extends LeafTask

export var target_field_name := ""

func execute() -> int:
	var host = tree.host
	host.attack((host.get(target_field_name).global_position - host.global_position).normalized())
	return self.Status.SUCCEEDED
