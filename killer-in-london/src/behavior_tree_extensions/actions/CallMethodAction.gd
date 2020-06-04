class_name CallMethodAction
extends LeafTask


export var method_name : = ""


func execute() -> int:
	var host = tree.host
	host.call(method_name)
	return self.Status.SUCCEEDED
